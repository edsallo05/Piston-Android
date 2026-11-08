import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/workshop_repository.dart';
import '../models/models.dart';
import '../viewmodels/history_view_model.dart';
import 'widgets/common.dart';
import 'widgets/order_widgets.dart';

/// Opens the service history of a vehicle.
void openVehicleHistory(BuildContext context, Vehicle vehicle) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => VehicleHistoryScreen(vehicle: vehicle)),
  );
}

/// Screen with every service a vehicle has had.
class VehicleHistoryScreen extends StatelessWidget {
  const VehicleHistoryScreen({super.key, required this.vehicle});

  final Vehicle vehicle;

  /// Creates the history ViewModel of this vehicle and shows the list.
  @override
  Widget build(BuildContext context) {
    return Provider<HistoryViewModel>(
      create: (context) {
        return HistoryViewModel(
          context.read<WorkshopRepository>(),
          vehicleId: vehicle.id,
        );
      },
      child: _VehicleHistoryView(vehicle: vehicle),
    );
  }
}

class _VehicleHistoryView extends StatelessWidget {
  const _VehicleHistoryView({required this.vehicle});

  final Vehicle vehicle;

  /// Builds the vehicle card and the list of past orders.
  @override
  Widget build(BuildContext context) {
    final historyViewModel = context.read<HistoryViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text(vehicle.plate)),
      body: StreamBuilder<List<OrderOverview>>(
        stream: historyViewModel.orders,
        builder: (context, snapshot) {
          final vehicleOrders = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
            children: [
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vehicle.brand} ${vehicle.model}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Año ${vehicle.year} · ${vehicle.mileage} km',
                      style: const TextStyle(color: mutedTextColor),
                    ),
                  ],
                ),
              ),
              const SectionHeader(title: 'Historial de servicios'),
              if (vehicleOrders.isEmpty)
                const SoftCard(child: Text('Sin servicios todavía', style: TextStyle(color: mutedTextColor)))
              else
                for (final order in vehicleOrders)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: OrderTile(order: order),
                  ),
            ],
          );
        },
      ),
    );
  }
}
