import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/workshop_repository.dart';
import '../models/models.dart';
import '../viewmodels/clients_view_model.dart';
import '../viewmodels/history_view_model.dart';
import 'vehicle_history_screen.dart';
import 'widgets/common.dart';
import 'widgets/form_dialog.dart';
import 'widgets/order_widgets.dart';

/// Opens the detail screen of a client.
void openClientDetail(BuildContext context, Client client) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => ClientDetailScreen(client: client)),
  );
}

/// Screen with the data, vehicles, debt and service history of one client.
class ClientDetailScreen extends StatelessWidget {
  const ClientDetailScreen({super.key, required this.client});

  final Client client;

  /// Creates the history ViewModel of this client and shows the content.
  @override
  Widget build(BuildContext context) {
    return Provider<HistoryViewModel>(
      create: (context) {
        return HistoryViewModel(
          context.read<WorkshopRepository>(),
          clientId: client.id,
        );
      },
      child: _ClientDetailView(client: client),
    );
  }
}

class _ClientDetailView extends StatelessWidget {
  const _ClientDetailView({required this.client});

  final Client client;

  /// Asks for the vehicle data and saves it for this client.
  Future<void> addVehicle(BuildContext context) async {
    final newestYear = DateTime.now().year + 1;
    final values = await showFormDialog(
      context,
      title: 'Nuevo vehículo',
      fields: [
        const FormFieldSpec(label: 'Matrícula', kind: FieldKind.plate, minLength: 4, maxLength: 10),
        const FormFieldSpec(label: 'Marca', maxLength: 30),
        const FormFieldSpec(label: 'Modelo', maxLength: 30),
        FormFieldSpec(label: 'Año', kind: FieldKind.integer, minValue: 1950, maxValue: newestYear.toDouble()),
        const FormFieldSpec(label: 'Kilometraje', kind: FieldKind.integer, minValue: 0, maxValue: 2000000),
      ],
    );
    if (values == null || !context.mounted) {
      return;
    }
    final viewModel = context.read<ClientsViewModel>();
    showResult(
      context,
      viewModel.addVehicle(
        clientId: client.id,
        plate: values[0],
        brand: values[1],
        model: values[2],
        year: int.parse(values[3]),
        mileage: int.parse(values[4]),
      ),
    );
  }

  /// Builds the client card, the vehicles and the history.
  @override
  Widget build(BuildContext context) {
    final historyViewModel = context.read<HistoryViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text(client.name)),
      body: StreamBuilder<List<OrderOverview>>(
        stream: historyViewModel.orders,
        builder: (context, snapshot) {
          final clientOrders = snapshot.data ?? [];
          final owed = historyViewModel.totalOwed(clientOrders);

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
            children: [
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(client.phone),
                    if (client.address != null) ...[
                      const SizedBox(height: 4),
                      Text(client.address!, style: const TextStyle(color: mutedTextColor)),
                    ],
                    const Divider(height: 24),
                    Row(
                      children: [
                        const Expanded(child: Text('Saldo pendiente')),
                        Text(
                          formatMoney(owed),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: owed > 0 ? dangerColor : const Color(0xFF2E9E5B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SectionHeader(title: 'Vehículos', onAdd: () => addVehicle(context)),
              StreamBuilder<List<Vehicle>>(
                stream: historyViewModel.vehicles,
                builder: (context, vehiclesSnapshot) {
                  final vehicles = vehiclesSnapshot.data ?? [];
                  if (vehicles.isEmpty) {
                    return const SoftCard(
                      child: Text('Este cliente aún no tiene vehículos', style: TextStyle(color: mutedTextColor)),
                    );
                  }
                  return Column(
                    children: [
                      for (final vehicle in vehicles)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: SoftCard(
                            onTap: () => openVehicleHistory(context, vehicle),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(vehicle.plate, style: const TextStyle(fontWeight: FontWeight.w700)),
                                      Text(
                                        '${vehicle.brand} ${vehicle.model} ${vehicle.year} · ${vehicle.mileage} km',
                                        style: const TextStyle(color: mutedTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: mutedTextColor),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SectionHeader(title: 'Historial'),
              if (clientOrders.isEmpty)
                const SoftCard(child: Text('Sin servicios todavía', style: TextStyle(color: mutedTextColor)))
              else
                for (final order in clientOrders)
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
