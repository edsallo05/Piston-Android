import '../data/database.dart';
import '../data/workshop_repository.dart';
import '../models/models.dart';

/// Service history of one client (clientId) or of one vehicle (vehicleId).
class HistoryViewModel {
  HistoryViewModel(this.repository, {this.clientId, this.vehicleId});

  final WorkshopRepository repository;
  final int? clientId;
  final int? vehicleId;

  /// Orders of this client or vehicle.
  late final Stream<List<OrderOverview>> orders =
      repository.watchOrderOverviews().map(_keepMatchingOrders);

  /// Vehicles of this client (only used when clientId is set).
  late final Stream<List<Vehicle>> vehicles =
      repository.watchVehiclesOfClient(clientId!);

  /// Keeps only the orders that belong to this client or vehicle.
  List<OrderOverview> _keepMatchingOrders(List<OrderOverview> allOrders) {
    return allOrders.where((order) {
      if (clientId != null && order.clientId != clientId) {
        return false;
      }
      if (vehicleId != null && order.vehicleId != vehicleId) {
        return false;
      }
      return true;
    }).toList();
  }

  /// Adds up what the client still owes in the given orders.
  double totalOwed(List<OrderOverview> clientOrders) {
    double owed = 0;
    for (final order in clientOrders) {
      if (order.status != OrderStatus.cancelled && !order.isPaid) {
        owed += order.balance;
      }
    }
    return owed;
  }
}
