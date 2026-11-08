import '../data/database.dart';
import '../data/workshop_repository.dart';
import '../models/models.dart';

/// Logic of the inventory screen.
class PartsViewModel {
  PartsViewModel(this.repository);

  final WorkshopRepository repository;

  /// Inventory with the parts about to run out first.
  late final Stream<List<Part>> parts =
      repository.watchParts().map(_putLowStockFirst);

  /// Number of parts about to run out (shown as a badge on the tab).
  late final Stream<int> lowStockCount = repository.watchParts().map(
        (allParts) => allParts.where((part) => part.isLowStock).length,
      );

  /// Sorts parts: low stock first, then alphabetically.
  List<Part> _putLowStockFirst(List<Part> allParts) {
    final sortedParts = List<Part>.of(allParts);
    sortedParts.sort((first, second) {
      if (first.isLowStock == second.isLowStock) {
        return first.name.toLowerCase().compareTo(second.name.toLowerCase());
      }
      return first.isLowStock ? -1 : 1;
    });
    return sortedParts;
  }

  /// Creates a part, or updates it when an id is given.
  Future<String?> savePart({
    int? id,
    required String name,
    required String code,
    required double salePrice,
    required int stock,
    required int lowStockThreshold,
  }) {
    return tryAction(() {
      return repository.savePart(
        id: id,
        name: name,
        code: code,
        salePrice: salePrice,
        stock: stock,
        lowStockThreshold: lowStockThreshold,
      );
    });
  }
}
