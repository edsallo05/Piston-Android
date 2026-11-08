import '../data/database.dart';
import '../data/workshop_repository.dart';
import '../models/models.dart';

/// Logic of the screen that shows one order.
class OrderDetailViewModel {
  OrderDetailViewModel(this.repository, this.orderId);

  final WorkshopRepository repository;
  final int orderId;

  /// This order with its totals.
  late final Stream<OrderOverview?> order =
      repository.watchOrderOverviews().map(_findThisOrder);

  /// Jobs done in this order.
  late final Stream<List<OrderJob>> jobs = repository.watchJobs(orderId);

  /// Parts used in this order.
  late final Stream<List<UsedPart>> usedParts = repository.watchUsedParts(orderId);

  /// Payments made for this order.
  late final Stream<List<Payment>> payments = repository.watchPayments(orderId);

  /// Looks for this order inside the list of all orders.
  OrderOverview? _findThisOrder(List<OrderOverview> allOrders) {
    for (final candidate in allOrders) {
      if (candidate.orderId == orderId) {
        return candidate;
      }
    }
    return null;
  }

  /// Changes the status of the order.
  Future<String?> changeStatus(OrderStatus newStatus) {
    return tryAction(() => repository.updateOrderStatus(orderId, newStatus));
  }

  /// Adds a job with its labor price.
  Future<String?> addJob(String description, double laborPrice) {
    return tryAction(() => repository.addJob(orderId, description, laborPrice));
  }

  /// Removes a job.
  Future<String?> deleteJob(int jobId) {
    return tryAction(() => repository.deleteJob(jobId));
  }

  /// Gets the parts that still have stock, to choose one.
  Future<List<Part>> loadAvailableParts() {
    return repository.getAvailableParts();
  }

  /// Uses a part in the order (the stock goes down).
  Future<String?> addPart(Part part, int quantity) {
    if (quantity <= 0) {
      return Future.value('La cantidad debe ser mayor que cero');
    }
    return tryAction(() {
      return repository.addPartToOrder(
        orderId: orderId,
        partId: part.id,
        quantity: quantity,
      );
    });
  }

  /// Removes a part from the order (the stock goes back up).
  Future<String?> removePart(OrderPart line) {
    return tryAction(() => repository.removePartFromOrder(line));
  }

  /// Registers a payment, checking it is positive and not bigger than the balance.
  Future<String?> addPayment(double amount, double currentBalance) {
    if (amount <= 0) {
      return Future.value('El monto debe ser mayor que cero');
    }
    if (amount > currentBalance + 0.009) {
      return Future.value('El pago supera el saldo pendiente');
    }
    return tryAction(() => repository.addPayment(orderId, amount));
  }
}
