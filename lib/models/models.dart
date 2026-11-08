import '../data/database.dart';

/// One order with all the data the screens need (vehicle, client, mechanic and money).
class OrderOverview {
  const OrderOverview({
    required this.orderId,
    required this.entryDate,
    required this.reportedProblem,
    required this.status,
    required this.vehicleId,
    required this.plate,
    required this.brand,
    required this.model,
    required this.clientId,
    required this.clientName,
    required this.clientPhone,
    required this.mechanicId,
    required this.mechanicName,
    required this.total,
    required this.paid,
  });

  final int orderId;
  final DateTime entryDate;
  final String reportedProblem;
  final OrderStatus status;
  final int vehicleId;
  final String plate;
  final String brand;
  final String model;
  final int clientId;
  final String clientName;
  final String clientPhone;
  final int mechanicId;
  final String mechanicName;
  final double total;
  final double paid;

  /// Money that the client still has to pay.
  double get balance => total - paid;

  /// True when there is nothing left to pay.
  bool get isPaid => balance < 0.01;
}

/// A part line used in an order together with the part itself.
class UsedPart {
  const UsedPart({required this.line, required this.part});

  final OrderPart line;
  final Part part;
}

/// A vehicle together with its owner.
class VehicleWithOwner {
  const VehicleWithOwner({required this.vehicle, required this.client});

  final Vehicle vehicle;
  final Client client;
}

extension OrderStatusInfo on OrderStatus {
  /// Text shown to the user for each status.
  String get label {
    switch (this) {
      case OrderStatus.received:
        return 'Recibida';
      case OrderStatus.diagnosing:
        return 'En diagnóstico';
      case OrderStatus.repairing:
        return 'En reparación';
      case OrderStatus.readyForPickup:
        return 'Lista para entregar';
      case OrderStatus.delivered:
        return 'Entregada';
      case OrderStatus.cancelled:
        return 'Cancelada';
    }
  }

  /// The next status in the normal flow, or null when the order is finished.
  OrderStatus? get nextStatus {
    switch (this) {
      case OrderStatus.received:
        return OrderStatus.diagnosing;
      case OrderStatus.diagnosing:
        return OrderStatus.repairing;
      case OrderStatus.repairing:
        return OrderStatus.readyForPickup;
      case OrderStatus.readyForPickup:
        return OrderStatus.delivered;
      case OrderStatus.delivered:
      case OrderStatus.cancelled:
        return null;
    }
  }

  /// An order is open until it is delivered or cancelled.
  bool get isOpen =>
      this != OrderStatus.delivered && this != OrderStatus.cancelled;
}

extension PartStockInfo on Part {
  /// True when the part is about to run out.
  bool get isLowStock => stock <= lowStockThreshold;
}
