import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../viewmodels/orders_view_model.dart';
import 'new_order_screen.dart';
import 'widgets/common.dart';
import 'widgets/order_widgets.dart';

/// Tab with the list of orders and filter chips.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  /// Text of each filter chip.
  String filterLabel(OrdersFilter filter) {
    switch (filter) {
      case OrdersFilter.open:
        return 'Abiertas';
      case OrdersFilter.ready:
        return 'Listas';
      case OrdersFilter.closed:
        return 'Cerradas';
      case OrdersFilter.all:
        return 'Todas';
    }
  }

  /// Builds the title, the filter chips and the list of orders.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OrdersViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NewOrderScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenTitle('Órdenes'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  for (final filter in OrdersFilter.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(filterLabel(filter)),
                        selected: viewModel.selectedFilter == filter,
                        onSelected: (_) => viewModel.selectFilter(filter),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<List<OrderOverview>>(
                stream: viewModel.orders,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final visibleOrders = viewModel.applyFilter(snapshot.data!);
                  if (visibleOrders.isEmpty) {
                    return const EmptyMessage('No hay órdenes aquí');
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    itemCount: visibleOrders.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return OrderTile(order: visibleOrders[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
