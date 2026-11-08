import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../viewmodels/clients_view_model.dart';
import 'client_detail_screen.dart';
import 'widgets/common.dart';
import 'widgets/form_dialog.dart';

/// Tab with the list of clients and a search box.
class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  /// Asks for the client data and saves the new client.
  Future<void> addClient(BuildContext context) async {
    final values = await showFormDialog(
      context,
      title: 'Nuevo cliente',
      fields: const [
        FormFieldSpec(label: 'Nombre', minLength: 2, maxLength: 60),
        FormFieldSpec(label: 'Teléfono', kind: FieldKind.phone, maxLength: 20),
        FormFieldSpec(label: 'Dirección', isRequired: false, maxLength: 120),
      ],
    );
    if (values == null || !context.mounted) {
      return;
    }
    final viewModel = context.read<ClientsViewModel>();
    showResult(context, viewModel.addClient(values[0], values[1], values[2]));
  }

  /// Builds the title, the search box and the list.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ClientsViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => addClient(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenTitle('Clientes'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: fieldDecoration('Buscar', prefixIcon: Icons.search),
                onChanged: viewModel.setSearchText,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<List<Client>>(
                stream: viewModel.clients,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final visibleClients = viewModel.applySearch(snapshot.data!);
                  if (visibleClients.isEmpty) {
                    return const EmptyMessage('No hay clientes. Toca + para agregar uno.');
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    itemCount: visibleClients.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final client = visibleClients[index];
                      return SoftCard(
                        onTap: () => openClientDetail(context, client),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    client.name,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(client.phone, style: const TextStyle(color: mutedTextColor)),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: mutedTextColor),
                          ],
                        ),
                      );
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
