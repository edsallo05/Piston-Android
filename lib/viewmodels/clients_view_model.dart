import 'package:flutter/foundation.dart';

import '../data/database.dart';
import '../data/workshop_repository.dart';

/// Logic of the clients list and of the forms to add clients and vehicles.
class ClientsViewModel extends ChangeNotifier {
  ClientsViewModel(this.repository);

  final WorkshopRepository repository;

  String searchText = '';

  /// All clients sorted by name.
  late final Stream<List<Client>> clients = repository.watchClients();

  /// Saves the text typed in the search box.
  void setSearchText(String newText) {
    searchText = newText;
    notifyListeners();
  }

  /// Keeps only the clients whose name or phone contains the search text.
  List<Client> applySearch(List<Client> allClients) {
    final query = searchText.trim().toLowerCase();
    if (query.isEmpty) {
      return allClients;
    }
    return allClients.where((client) {
      return client.name.toLowerCase().contains(query) ||
          client.phone.contains(query);
    }).toList();
  }

  /// Saves a new client. The address can be empty.
  Future<String?> addClient(String name, String phone, String address) {
    final cleanAddress = address.isEmpty ? null : address;
    return tryAction(() => repository.addClient(name, phone, cleanAddress));
  }

  /// Saves a new vehicle for a client.
  Future<String?> addVehicle({
    required int clientId,
    required String plate,
    required String brand,
    required String model,
    required int year,
    required int mileage,
  }) {
    return tryAction(() {
      return repository.addVehicle(
        clientId: clientId,
        plate: plate,
        brand: brand,
        model: model,
        year: year,
        mileage: mileage,
      );
    });
  }
}
