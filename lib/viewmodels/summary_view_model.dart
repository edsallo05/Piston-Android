import 'package:flutter/foundation.dart';

import '../data/database.dart';
import '../data/workshop_repository.dart';
import '../models/models.dart';

/// How much one client owes in total.
class ClientDebt {
  const ClientDebt({
    required this.clientName,
    required this.clientPhone,
    required this.amount,
  });

  final String clientName;
  final String clientPhone;
  final double amount;
}

/// Logic of the summary screen: billing, debts, workload and low stock.
class SummaryViewModel extends ChangeNotifier {
  SummaryViewModel(this.repository) {
    final today = DateTime.now();
    periodStart = DateTime(today.year, today.month, 1);
    periodEnd = DateTime(today.year, today.month, today.day);
  }

  final WorkshopRepository repository;

  late DateTime periodStart;
  late DateTime periodEnd;

  /// All orders, used to calculate every number of the summary.
  late final Stream<List<OrderOverview>> orders = repository.watchOrderOverviews();

  /// Mechanics, to show their workload.
  late final Stream<List<Mechanic>> mechanics = repository.watchMechanics();

  /// Parts that are about to run out.
  late final Stream<List<Part>> lowStockParts = repository.watchParts().map(
        (allParts) => allParts.where((part) => part.isLowStock).toList(),
      );

  /// Changes the period used to calculate billing.
  void setPeriod(DateTime newStart, DateTime newEnd) {
    periodStart = DateTime(newStart.year, newStart.month, newStart.day);
    periodEnd = DateTime(newEnd.year, newEnd.month, newEnd.day);
    notifyListeners();
  }

  /// True when the date is inside the selected period (both days included).
  bool _isInPeriod(DateTime date) {
    final dayAfterEnd = periodEnd.add(const Duration(days: 1));
    return !date.isBefore(periodStart) && date.isBefore(dayAfterEnd);
  }

  /// Orders of the period that were not cancelled.
  List<OrderOverview> _ordersInPeriod(List<OrderOverview> allOrders) {
    return allOrders.where((order) {
      return order.status != OrderStatus.cancelled && _isInPeriod(order.entryDate);
    }).toList();
  }

  /// Total billed (labor plus parts) in the period.
  double billedInPeriod(List<OrderOverview> allOrders) {
    double billed = 0;
    for (final order in _ordersInPeriod(allOrders)) {
      billed += order.total;
    }
    return billed;
  }

  /// Total already paid for the orders of the period.
  double collectedInPeriod(List<OrderOverview> allOrders) {
    double collected = 0;
    for (final order in _ordersInPeriod(allOrders)) {
      collected += order.paid;
    }
    return collected;
  }

  /// How much each client owes, from the biggest debt to the smallest.
  List<ClientDebt> clientDebts(List<OrderOverview> allOrders) {
    final debtsByClient = <int, ClientDebt>{};

    for (final order in allOrders) {
      if (order.status == OrderStatus.cancelled || order.isPaid) {
        continue;
      }
      final previousAmount = debtsByClient[order.clientId]?.amount ?? 0;
      debtsByClient[order.clientId] = ClientDebt(
        clientName: order.clientName,
        clientPhone: order.clientPhone,
        amount: previousAmount + order.balance,
      );
    }

    final debts = debtsByClient.values.toList();
    debts.sort((first, second) => second.amount.compareTo(first.amount));
    return debts;
  }

  /// Number of open orders assigned to a mechanic.
  int openOrdersOf(int mechanicId, List<OrderOverview> allOrders) {
    return allOrders.where((order) {
      return order.mechanicId == mechanicId && order.status.isOpen;
    }).length;
  }

  /// Changes the name of a mechanic.
  Future<String?> renameMechanic(int mechanicId, String newName) {
    return tryAction(() => repository.renameMechanic(mechanicId, newName));
  }
}
