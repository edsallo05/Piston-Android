import 'package:flutter/foundation.dart';

import '../data/database.dart';
import '../data/workshop_repository.dart';
import '../models/models.dart';

/// Filters available on the orders list.
enum OrdersFilter { open, ready, closed, all }

/// Logic of the orders list and of the "new order" form.
class OrdersViewModel extends ChangeNotifier {
  OrdersViewModel(this.repository);

  final WorkshopRepository repository;

  OrdersFilter selectedFilter = OrdersFilter.open;

  /// All orders, updated automatically when the database changes.
  late final Stream<List<OrderOverview>> orders = repository.watchOrderOverviews();

  /// Changes the active filter chip.
  void selectFilter(OrdersFilter newFilter) {
    selectedFilter = newFilter;
    notifyListeners();
  }

  /// Keeps only the orders that match the active filter.
  List<OrderOverview> applyFilter(List<OrderOverview> allOrders) {
    return allOrders.where((order) {
      switch (selectedFilter) {
        case OrdersFilter.open:
          return order.status.isOpen;
        case OrdersFilter.ready:
          return order.status == OrderStatus.readyForPickup;
        case OrdersFilter.closed:
          return !order.status.isOpen;
        case OrdersFilter.all:
          return true;
      }
    }).toList();
  }

  /// Vehicles the user can choose when creating an order.
  Stream<List<VehicleWithOwner>> watchVehicles() {
    return repository.watchVehiclesWithOwner();
  }

  /// Mechanics the user can assign to an order.
  Stream<List<Mechanic>> watchMechanics() {
    return repository.watchMechanics();
  }

  /// Creates an order. Returns an error message or null if it worked.
  Future<String?> createOrder({
    required int vehicleId,
    required int mechanicId,
    required String reportedProblem,
    required int mileage,
  }) {
    return tryAction(() {
      return repository.createOrder(
        vehicleId: vehicleId,
        mechanicId: mechanicId,
        reportedProblem: reportedProblem,
        mileage: mileage,
      );
    });
  }
}
