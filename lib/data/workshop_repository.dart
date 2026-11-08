import 'package:drift/drift.dart';

import '../models/models.dart';
import 'database.dart';

/// An error with a message that can be shown directly to the user.
class WorkshopException implements Exception {
  WorkshopException(this.message);

  final String message;
}

/// Turns any error into a short message for the user.
String describeError(Object error) {
  if (error is WorkshopException) {
    return error.message;
  }
  return 'No se pudo guardar. Revisa que los datos no estén repetidos.';
}

/// Runs an action and returns an error message, or null when everything went well.
Future<String?> tryAction(Future<void> Function() action) async {
  try {
    await action();
    return null;
  } catch (error) {
    return describeError(error);
  }
}

/// The only class that talks to the database. ViewModels use it for everything.
class WorkshopRepository {
  WorkshopRepository(this.database);

  final AppDatabase database;

  // ---------------------------------------------------------------- Orders

  /// Watches every order with its vehicle, client, mechanic, total and amount paid.
  Stream<List<OrderOverview>> watchOrderOverviews() {
    const query = '''
      SELECT
        o.id AS order_id,
        o.entry_date AS entry_date,
        o.reported_problem AS reported_problem,
        o.status AS status,
        v.id AS vehicle_id,
        v.plate AS plate,
        v.brand AS brand,
        v.model AS model,
        c.id AS client_id,
        c.name AS client_name,
        c.phone AS client_phone,
        m.id AS mechanic_id,
        m.name AS mechanic_name,
        CAST(
          (SELECT COALESCE(SUM(labor_price), 0.0) FROM order_jobs WHERE order_id = o.id)
          + (SELECT COALESCE(SUM(quantity * unit_price), 0.0) FROM order_parts WHERE order_id = o.id)
          AS REAL) AS total,
        CAST(
          (SELECT COALESCE(SUM(amount), 0.0) FROM payments WHERE order_id = o.id)
          AS REAL) AS paid
      FROM service_orders o
      JOIN vehicles v ON v.id = o.vehicle_id
      JOIN clients c ON c.id = v.client_id
      JOIN mechanics m ON m.id = o.mechanic_id
      ORDER BY o.entry_date DESC, o.id DESC
    ''';

    return database
        .customSelect(
          query,
          readsFrom: {
            database.serviceOrders,
            database.vehicles,
            database.clients,
            database.mechanics,
            database.orderJobs,
            database.orderParts,
            database.payments,
          },
        )
        .watch()
        .map((rows) => rows.map(_rowToOrderOverview).toList());
  }

  /// Converts one database row into an OrderOverview.
  OrderOverview _rowToOrderOverview(QueryRow row) {
    return OrderOverview(
      orderId: row.read<int>('order_id'),
      entryDate: row.read<DateTime>('entry_date'),
      reportedProblem: row.read<String>('reported_problem'),
      status: OrderStatus.values[row.read<int>('status')],
      vehicleId: row.read<int>('vehicle_id'),
      plate: row.read<String>('plate'),
      brand: row.read<String>('brand'),
      model: row.read<String>('model'),
      clientId: row.read<int>('client_id'),
      clientName: row.read<String>('client_name'),
      clientPhone: row.read<String>('client_phone'),
      mechanicId: row.read<int>('mechanic_id'),
      mechanicName: row.read<String>('mechanic_name'),
      total: row.read<double>('total'),
      paid: row.read<double>('paid'),
    );
  }

  /// Creates a new order (status "received") and saves the mileage the vehicle arrived with.
  Future<void> createOrder({
    required int vehicleId,
    required int mechanicId,
    required String reportedProblem,
    required int mileage,
  }) {
    return database.transaction(() async {
      await database.into(database.serviceOrders).insert(
            ServiceOrdersCompanion.insert(
              vehicleId: vehicleId,
              mechanicId: mechanicId,
              entryDate: DateTime.now(),
              reportedProblem: reportedProblem,
              status: OrderStatus.received,
            ),
          );
      await (database.update(database.vehicles)
            ..where((table) => table.id.equals(vehicleId)))
          .write(VehiclesCompanion(mileage: Value(mileage)));
    });
  }

  /// Changes the status of an order.
  Future<void> updateOrderStatus(int orderId, OrderStatus newStatus) {
    return (database.update(database.serviceOrders)
          ..where((table) => table.id.equals(orderId)))
        .write(ServiceOrdersCompanion(status: Value(newStatus)));
  }

  // ------------------------------------------------- Jobs, parts, payments

  /// Watches the jobs done in an order.
  Stream<List<OrderJob>> watchJobs(int orderId) {
    return (database.select(database.orderJobs)
          ..where((table) => table.orderId.equals(orderId)))
        .watch();
  }

  /// Adds a job with its labor price to an order.
  Future<void> addJob(int orderId, String description, double laborPrice) {
    return database.into(database.orderJobs).insert(
          OrderJobsCompanion.insert(
            orderId: orderId,
            description: description,
            laborPrice: laborPrice,
          ),
        );
  }

  /// Removes a job from an order.
  Future<void> deleteJob(int jobId) {
    return (database.delete(database.orderJobs)
          ..where((table) => table.id.equals(jobId)))
        .go();
  }

  /// Watches the parts used in an order.
  Stream<List<UsedPart>> watchUsedParts(int orderId) {
    final query = database.select(database.orderParts).join([
      innerJoin(
        database.parts,
        database.parts.id.equalsExp(database.orderParts.partId),
      ),
    ])
      ..where(database.orderParts.orderId.equals(orderId));

    return query.watch().map((rows) {
      return rows.map((row) {
        return UsedPart(
          line: row.readTable(database.orderParts),
          part: row.readTable(database.parts),
        );
      }).toList();
    });
  }

  /// Adds a part to an order and lowers the stock. Fails if there is not enough stock.
  Future<void> addPartToOrder({
    required int orderId,
    required int partId,
    required int quantity,
  }) {
    return database.transaction(() async {
      final currentPart = await (database.select(database.parts)
            ..where((table) => table.id.equals(partId)))
          .getSingle();

      if (currentPart.stock < quantity) {
        throw WorkshopException('Solo quedan ${currentPart.stock} en existencias');
      }

      await database.into(database.orderParts).insert(
            OrderPartsCompanion.insert(
              orderId: orderId,
              partId: partId,
              quantity: quantity,
              unitPrice: currentPart.salePrice,
            ),
          );
      await (database.update(database.parts)
            ..where((table) => table.id.equals(partId)))
          .write(PartsCompanion(stock: Value(currentPart.stock - quantity)));
    });
  }

  /// Removes a part from an order and returns its units to the stock.
  Future<void> removePartFromOrder(OrderPart line) {
    return database.transaction(() async {
      final currentPart = await (database.select(database.parts)
            ..where((table) => table.id.equals(line.partId)))
          .getSingle();

      await (database.update(database.parts)
            ..where((table) => table.id.equals(line.partId)))
          .write(PartsCompanion(stock: Value(currentPart.stock + line.quantity)));
      await (database.delete(database.orderParts)
            ..where((table) => table.id.equals(line.id)))
          .go();
    });
  }

  /// Watches the payments of an order.
  Stream<List<Payment>> watchPayments(int orderId) {
    return (database.select(database.payments)
          ..where((table) => table.orderId.equals(orderId))
          ..orderBy([(table) => OrderingTerm.desc(table.paidDate)]))
        .watch();
  }

  /// Registers a payment for an order.
  Future<void> addPayment(int orderId, double amount) {
    return database.into(database.payments).insert(
          PaymentsCompanion.insert(
            orderId: orderId,
            amount: amount,
            paidDate: DateTime.now(),
          ),
        );
  }

  // ------------------------------------------------- Clients and vehicles

  /// Watches all clients sorted by name.
  Stream<List<Client>> watchClients() {
    return (database.select(database.clients)
          ..orderBy([(table) => OrderingTerm.asc(table.name)]))
        .watch();
  }

  /// Saves a new client.
  Future<void> addClient(String name, String phone, String? address) async {
    final sameClient = await (database.select(database.clients)
          ..where((table) {
            return table.phone.equals(phone) &
                table.name.lower().equals(name.toLowerCase());
          }))
        .get();
    if (sameClient.isNotEmpty) {
      throw WorkshopException('Ya existe un cliente con ese nombre y teléfono');
    }

    await database.into(database.clients).insert(
          ClientsCompanion.insert(
            name: name,
            phone: phone,
            address: Value(address),
          ),
        );
  }

  /// Watches the vehicles of one client.
  Stream<List<Vehicle>> watchVehiclesOfClient(int clientId) {
    return (database.select(database.vehicles)
          ..where((table) => table.clientId.equals(clientId))
          ..orderBy([(table) => OrderingTerm.asc(table.plate)]))
        .watch();
  }

  /// Watches all vehicles together with their owners.
  Stream<List<VehicleWithOwner>> watchVehiclesWithOwner() {
    final query = database.select(database.vehicles).join([
      innerJoin(
        database.clients,
        database.clients.id.equalsExp(database.vehicles.clientId),
      ),
    ])
      ..orderBy([OrderingTerm.asc(database.vehicles.plate)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return VehicleWithOwner(
          vehicle: row.readTable(database.vehicles),
          client: row.readTable(database.clients),
        );
      }).toList();
    });
  }

  /// Saves a new vehicle for a client.
  Future<void> addVehicle({
    required int clientId,
    required String plate,
    required String brand,
    required String model,
    required int year,
    required int mileage,
  }) async {
    final normalizedPlate = plate.trim().toUpperCase();
    final samePlate = await (database.select(database.vehicles)
          ..where((table) => table.plate.equals(normalizedPlate)))
        .get();
    if (samePlate.isNotEmpty) {
      throw WorkshopException('Ya existe un vehículo con la matrícula $normalizedPlate');
    }

    await database.into(database.vehicles).insert(
          VehiclesCompanion.insert(
            clientId: clientId,
            plate: normalizedPlate,
            brand: brand,
            model: model,
            year: year,
            mileage: mileage,
          ),
        );
  }

  // ------------------------------------------------------ Parts, mechanics

  /// Watches the inventory sorted by name.
  Stream<List<Part>> watchParts() {
    return (database.select(database.parts)
          ..orderBy([(table) => OrderingTerm.asc(table.name)]))
        .watch();
  }

  /// Gets once the parts that still have stock.
  Future<List<Part>> getAvailableParts() {
    return (database.select(database.parts)
          ..where((table) => table.stock.isBiggerThanValue(0))
          ..orderBy([(table) => OrderingTerm.asc(table.name)]))
        .get();
  }

  /// Creates a part (when id is null) or updates an existing one.
  Future<void> savePart({
    int? id,
    required String name,
    required String code,
    required double salePrice,
    required int stock,
    required int lowStockThreshold,
  }) async {
    if (salePrice <= 0 || stock < 0 || lowStockThreshold < 0) {
      throw WorkshopException('El precio debe ser positivo y las cantidades no pueden ser negativas');
    }

    final partsWithSameCode = await (database.select(database.parts)
          ..where((table) => table.code.lower().equals(code.toLowerCase())))
        .get();
    final isUsedByAnotherPart = partsWithSameCode.any((part) => part.id != id);
    if (isUsedByAnotherPart) {
      throw WorkshopException('Ya existe un repuesto con el código $code');
    }

    if (id == null) {
      await database.into(database.parts).insert(
            PartsCompanion.insert(
              name: name,
              code: code,
              salePrice: salePrice,
              stock: stock,
              lowStockThreshold: Value(lowStockThreshold),
            ),
          );
      return;
    }
    await (database.update(database.parts)
          ..where((table) => table.id.equals(id)))
        .write(
      PartsCompanion(
        name: Value(name),
        code: Value(code),
        salePrice: Value(salePrice),
        stock: Value(stock),
        lowStockThreshold: Value(lowStockThreshold),
      ),
    );
  }

  /// Watches the mechanics.
  Stream<List<Mechanic>> watchMechanics() {
    return (database.select(database.mechanics)
          ..orderBy([(table) => OrderingTerm.asc(table.id)]))
        .watch();
  }

  /// Changes the name of a mechanic.
  Future<void> renameMechanic(int mechanicId, String newName) {
    return (database.update(database.mechanics)
          ..where((table) => table.id.equals(mechanicId)))
        .write(MechanicsCompanion(name: Value(newName)));
  }
}
