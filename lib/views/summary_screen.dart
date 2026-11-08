import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../models/models.dart';
import '../viewmodels/summary_view_model.dart';
import 'widgets/common.dart';
import 'widgets/form_dialog.dart';

/// Tab with the numbers the owner needs: billing, debts, workload and low stock.
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  /// Lets the user pick the dates used to calculate billing.
  Future<void> pickPeriod(BuildContext context, SummaryViewModel viewModel) async {
    final pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: viewModel.periodStart,
        end: viewModel.periodEnd,
      ),
    );
    if (pickedRange != null) {
      viewModel.setPeriod(pickedRange.start, pickedRange.end);
    }
  }

  /// Builds a small card with a label and a big number.
  Widget metricCard(String label, double amount) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: mutedTextColor)),
          const SizedBox(height: 4),
          Text(
            formatMoney(amount),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  /// Builds one row with a title, a subtitle and a value on the right.
  Widget infoRow(String title, String subtitle, String value, {Color? valueColor, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  if (subtitle.isNotEmpty)
                    Text(subtitle, style: const TextStyle(color: mutedTextColor, fontSize: 13)),
                ],
              ),
            ),
            Text(value, style: TextStyle(fontWeight: FontWeight.w700, color: valueColor)),
          ],
        ),
      ),
    );
  }

  /// Asks for a new name and renames the mechanic.
  Future<void> renameMechanic(BuildContext context, Mechanic mechanic) async {
    final values = await showFormDialog(
      context,
      title: 'Nombre del mecánico',
      fields: [
        FormFieldSpec(
          label: 'Nombre',
          minLength: 2,
          maxLength: 40,
          initialValue: mechanic.name,
        ),
      ],
    );
    if (values == null || !context.mounted) {
      return;
    }
    final viewModel = context.read<SummaryViewModel>();
    showResult(context, viewModel.renameMechanic(mechanic.id, values[0]));
  }

  /// Builds every block of the summary.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SummaryViewModel>();

    return SafeArea(
      child: StreamBuilder<List<OrderOverview>>(
        stream: viewModel.orders,
        builder: (context, snapshot) {
          final allOrders = snapshot.data ?? [];
          final debts = viewModel.clientDebts(allOrders);

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            children: [
              const ScreenTitle('Resumen'),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => pickPeriod(context, viewModel),
                  icon: const Icon(Icons.date_range),
                  label: Text(
                    '${formatDate(viewModel.periodStart)} - ${formatDate(viewModel.periodEnd)}',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: metricCard('Facturado', viewModel.billedInPeriod(allOrders))),
                  const SizedBox(width: 12),
                  Expanded(child: metricCard('Cobrado', viewModel.collectedInPeriod(allOrders))),
                ],
              ),
              const SectionHeader(title: 'Repuestos por agotarse'),
              StreamBuilder<List<Part>>(
                stream: viewModel.lowStockParts,
                builder: (context, lowStockSnapshot) {
                  final lowStockParts = lowStockSnapshot.data ?? [];
                  if (lowStockParts.isEmpty) {
                    return const SoftCard(
                      child: Text('Todo en orden', style: TextStyle(color: mutedTextColor)),
                    );
                  }
                  return SoftCard(
                    child: Column(
                      children: [
                        for (final part in lowStockParts)
                          infoRow(part.name, part.code, 'Quedan ${part.stock}', valueColor: warningColor),
                      ],
                    ),
                  );
                },
              ),
              const SectionHeader(title: 'Carga de los mecánicos'),
              StreamBuilder<List<Mechanic>>(
                stream: viewModel.mechanics,
                builder: (context, mechanicsSnapshot) {
                  final mechanics = mechanicsSnapshot.data ?? [];
                  return SoftCard(
                    child: Column(
                      children: [
                        for (final mechanic in mechanics)
                          infoRow(
                            mechanic.name,
                            'Toca para cambiar el nombre',
                            '${viewModel.openOrdersOf(mechanic.id, allOrders)} abiertas',
                            onTap: () => renameMechanic(context, mechanic),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SectionHeader(title: 'Saldos pendientes'),
              if (debts.isEmpty)
                const SoftCard(
                  child: Text('Nadie debe nada', style: TextStyle(color: mutedTextColor)),
                )
              else
                SoftCard(
                  child: Column(
                    children: [
                      for (final debt in debts)
                        infoRow(
                          debt.clientName,
                          debt.clientPhone,
                          formatMoney(debt.amount),
                          valueColor: dangerColor,
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
