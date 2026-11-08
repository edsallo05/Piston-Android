import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// Every state an order can go through.
/// The order of the values matters: it is the order used to move an order forward.
enum OrderStatus {
  received,
  diagnosing,
  repairing,
  readyForPickup,
  delivered,
  cancelled,
}

/// People who bring their vehicles to the workshop.
class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text()();
  TextColumn get address => text().nullable()();
}

/// Vehicles. One client can have many vehicles.
class Vehicles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  TextColumn get plate => text().unique()();
  TextColumn get brand => text()();
  TextColumn get model => text()();
  IntColumn get year => integer()();
  IntColumn get mileage => integer()();
}

/// Workshop mechanics. Orders are assigned to them.
class Mechanics extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

/// One visit of a vehicle to the workshop.
class ServiceOrders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehicleId => integer().references(Vehicles, #id)();
  IntColumn get mechanicId => integer().references(Mechanics, #id)();
  DateTimeColumn get entryDate => dateTime()();
  TextColumn get reportedProblem => text()();
  IntColumn get status => intEnum<OrderStatus>()();
}

/// Spare parts inventory.
class Parts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get code => text().unique()();
  RealColumn get salePrice => real()();
  IntColumn get stock => integer()();
  IntColumn get lowStockThreshold => integer().withDefault(const Constant(3))();
}

/// Work done in an order (for example an oil change) with its labor price.
class OrderJobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ServiceOrders, #id)();
  TextColumn get description => text()();
  RealColumn get laborPrice => real()();
}

/// Parts used in an order. The unit price is copied so old orders never change.
class OrderParts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ServiceOrders, #id)();
  IntColumn get partId => integer().references(Parts, #id)();
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real()();
}

/// Payments made for an order. A client can pay in several parts.
class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer().references(ServiceOrders, #id)();
  RealColumn get amount => real()();
  DateTimeColumn get paidDate => dateTime()();
}

@DriftDatabase(
  tables: [
    Clients,
    Vehicles,
    Mechanics,
    ServiceOrders,
    Parts,
    OrderJobs,
    OrderParts,
    Payments,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Opens (or creates) the database file stored in the phone.
  AppDatabase() : super(driftDatabase(name: 'el_piston'));

  @override
  int get schemaVersion => 1;

  /// Creates the tables and adds the two mechanics the first time the app runs.
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();
        await into(mechanics).insert(MechanicsCompanion.insert(name: 'Mecánico 1'));
        await into(mechanics).insert(MechanicsCompanion.insert(name: 'Mecánico 2'));
      },
    );
  }
}
