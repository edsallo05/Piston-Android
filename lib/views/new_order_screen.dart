import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../models/models.dart';
import '../viewmodels/orders_view_model.dart';
import 'widgets/common.dart';

/// Form to create a new order: choose vehicle, mechanic and describe the problem.
class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  final mileageController = TextEditingController();
  final problemController = TextEditingController();

  late final Stream<List<VehicleWithOwner>> vehiclesStream;
  late final Stream<List<Mechanic>> mechanicsStream;

  List<Mechanic> availableMechanics = [];
  VehicleWithOwner? selectedVehicle;
  int? selectedMechanicId;
  String searchText = '';

  /// Starts watching vehicles and mechanics once, when the screen opens.
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<OrdersViewModel>();
    vehiclesStream = viewModel.watchVehicles();
    mechanicsStream = viewModel.watchMechanics();
  }

  /// Frees the text controllers.
  @override
  void dispose() {
    searchController.dispose();
    mileageController.dispose();
    problemController.dispose();
    super.dispose();
  }

  /// Returns at most 5 vehicles that match the search text (plate or client name).
  List<VehicleWithOwner> filterVehicles(List<VehicleWithOwner> allVehicles) {
    final query = searchText.trim().toLowerCase();
    if (query.isEmpty) {
      return allVehicles.take(5).toList();
    }
    return allVehicles.where((item) {
      return item.vehicle.plate.toLowerCase().contains(query) ||
          item.client.name.toLowerCase().contains(query);
    }).take(5).toList();
  }

  /// Marks a vehicle as selected and fills in its last known mileage.
  void selectVehicle(VehicleWithOwner item) {
    setState(() {
      selectedVehicle = item;
      mileageController.text = item.vehicle.mileage.toString();
    });
  }

  /// Checks the mileage: a whole number, not lower than the last one saved for the vehicle.
  String? validateMileage(String? text) {
    final value = (text ?? '').trim();
    if (!RegExp(r'^\d+$').hasMatch(value) || value.length > 7) {
      return 'Escribe un número entero, sin signos ni decimales';
    }
    final mileage = int.parse(value);
    if (mileage > 2000000) {
      return 'El kilometraje no puede superar 2000000';
    }
    final lastMileage = selectedVehicle?.vehicle.mileage;
    if (lastMileage != null && mileage < lastMileage) {
      return 'No puede ser menor al último registrado ($lastMileage km)';
    }
    return null;
  }

  /// Checks the problem description: between 5 and 300 characters.
  String? validateProblem(String? text) {
    final value = (text ?? '').trim();
    if (value.isEmpty) {
      return 'Campo obligatorio';
    }
    if (value.length < 5) {
      return 'Describe el problema con al menos 5 caracteres';
    }
    if (value.length > 300) {
      return 'Máximo 300 caracteres';
    }
    return null;
  }

  /// Validates the form and creates the order.
  Future<void> saveOrder() async {
    if (selectedVehicle == null) {
      showMessage(context, 'Elige un vehículo');
      return;
    }
    if (availableMechanics.isEmpty) {
      showMessage(context, 'No hay mecánicos registrados');
      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }

    final mechanicId = selectedMechanicId ?? availableMechanics.first.id;
    final errorMessage = await context.read<OrdersViewModel>().createOrder(
          vehicleId: selectedVehicle!.vehicle.id,
          mechanicId: mechanicId,
          reportedProblem: problemController.text.trim(),
          mileage: int.parse(mileageController.text.trim()),
        );

    if (!mounted) {
      return;
    }
    if (errorMessage != null) {
      showMessage(context, errorMessage);
      return;
    }
    Navigator.of(context).pop();
  }

  /// Builds the form.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva orden')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
          children: [
            const SectionHeader(title: 'Vehículo'),
            TextField(
              controller: searchController,
              decoration: fieldDecoration(
                'Buscar por matrícula o cliente',
                prefixIcon: Icons.search,
              ),
              onChanged: (text) => setState(() => searchText = text),
            ),
            const SizedBox(height: 12),
            StreamBuilder<List<VehicleWithOwner>>(
              stream: vehiclesStream,
              builder: (context, snapshot) {
                final matches = filterVehicles(snapshot.data ?? []);
                if (matches.isEmpty) {
                  return const EmptyMessage(
                    'No hay vehículos. Registra uno desde la pestaña Clientes.',
                  );
                }
                return Column(
                  children: [
                    for (final item in matches)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SoftCard(
                          borderColor: selectedVehicle?.vehicle.id == item.vehicle.id
                              ? accentColor
                              : null,
                          onTap: () => selectVehicle(item),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.vehicle.plate,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '${item.vehicle.brand} ${item.vehicle.model} · ${item.client.name}',
                                style: const TextStyle(color: mutedTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SectionHeader(title: 'Mecánico'),
            StreamBuilder<List<Mechanic>>(
              stream: mechanicsStream,
              builder: (context, snapshot) {
                availableMechanics = snapshot.data ?? [];
                if (availableMechanics.isEmpty) {
                  return const SizedBox.shrink();
                }
                final activeMechanicId =
                    selectedMechanicId ?? availableMechanics.first.id;
                return Wrap(
                  spacing: 8,
                  children: [
                    for (final mechanic in availableMechanics)
                      ChoiceChip(
                        label: Text(mechanic.name),
                        selected: mechanic.id == activeMechanicId,
                        onSelected: (_) {
                          setState(() => selectedMechanicId = mechanic.id);
                        },
                      ),
                  ],
                );
              },
            ),
            const SectionHeader(title: 'Detalles'),
            TextFormField(
              controller: mileageController,
              keyboardType: TextInputType.number,
              decoration: fieldDecoration('Kilometraje actual'),
              validator: validateMileage,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: problemController,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: fieldDecoration('Problema reportado'),
              validator: validateProblem,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: FilledButton(
                onPressed: saveOrder,
                child: const Text('Crear orden'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
