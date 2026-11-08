import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../models/models.dart';
import '../viewmodels/parts_view_model.dart';
import 'widgets/common.dart';
import 'widgets/form_dialog.dart';

/// Tab with the spare parts inventory.
class PartsScreen extends StatelessWidget {
  const PartsScreen({super.key});

  /// Shows the part form (empty for a new part, filled to edit one) and saves it.
  Future<void> openPartForm(BuildContext context, {Part? existingPart}) async {
    final values = await showFormDialog(
      context,
      title: existingPart == null ? 'Nuevo repuesto' : 'Editar repuesto',
      fields: [
        FormFieldSpec(
          label: 'Nombre',
          minLength: 2,
          initialValue: existingPart?.name ?? '',
        ),
        FormFieldSpec(
          label: 'Código',
          kind: FieldKind.code,
          minLength: 2,
          maxLength: 20,
          initialValue: existingPart?.code ?? '',
        ),
        FormFieldSpec(
          label: 'Precio de venta',
          kind: FieldKind.money,
          minValue: 0.01,
          maxValue: 1000000,
          initialValue: existingPart?.salePrice.toStringAsFixed(2) ?? '',
        ),
        FormFieldSpec(
          label: 'Existencias',
          kind: FieldKind.integer,
          minValue: 0,
          maxValue: 100000,
          initialValue: existingPart?.stock.toString() ?? '',
        ),
        FormFieldSpec(
          label: 'Avisar cuando queden',
          kind: FieldKind.integer,
          minValue: 0,
          maxValue: 1000,
          initialValue: existingPart?.lowStockThreshold.toString() ?? '3',
        ),
      ],
    );
    if (values == null || !context.mounted) {
      return;
    }
    final viewModel = context.read<PartsViewModel>();
    showResult(
      context,
      viewModel.savePart(
        id: existingPart?.id,
        name: values[0],
        code: values[1],
        salePrice: parseDecimal(values[2])!,
        stock: int.parse(values[3]),
        lowStockThreshold: int.parse(values[4]),
      ),
    );
  }

  /// Builds the title and the list of parts.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<PartsViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => openPartForm(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenTitle('Repuestos'),
            Expanded(
              child: StreamBuilder<List<Part>>(
                stream: viewModel.parts,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final parts = snapshot.data!;
                  if (parts.isEmpty) {
                    return const EmptyMessage('El inventario está vacío. Toca + para agregar un repuesto.');
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    itemCount: parts.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final part = parts[index];
                      return SoftCard(
                        onTap: () => openPartForm(context, existingPart: part),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(part.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${part.code} · ${formatMoney(part.salePrice)}',
                                    style: const TextStyle(color: mutedTextColor),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${part.stock}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: part.isLowStock ? warningColor : null,
                                  ),
                                ),
                                if (part.isLowStock)
                                  const Text(
                                    'Pocas unidades',
                                    style: TextStyle(color: warningColor, fontSize: 12),
                                  ),
                              ],
                            ),
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
