import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/workshop_repository.dart';
import '../models/models.dart';
import '../viewmodels/order_detail_view_model.dart';
import 'widgets/common.dart';
import 'widgets/form_dialog.dart';
import 'widgets/order_widgets.dart';

/// Opens the detail screen of an order.
void openOrderDetail(BuildContext context, int orderId) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: orderId)),
  );
}

/// Screen that shows one order: status, jobs, parts and payments.
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final int orderId;

  /// Creates the ViewModel of this order and shows the content.
  @override
  Widget build(BuildContext context) {
    return Provider<OrderDetailViewModel>(
      create: (context) {
        return OrderDetailViewModel(context.read<WorkshopRepository>(), orderId);
      },
      child: const _OrderDetailView(),
    );
  }
}

class _OrderDetailView extends StatelessWidget {
  const _OrderDetailView();

  /// Changes the status. Cancelling an order asks for confirmation first.
  Future<void> changeStatus(
    BuildContext context,
    OrderDetailViewModel viewModel,
    OrderStatus newStatus,
  ) async {
    if (newStatus == OrderStatus.cancelled) {
      final isConfirmed = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('¿Cancelar la orden?'),
            content: const Text('La orden quedará marcada como cancelada.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Volver'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Cancelar orden'),
              ),
            ],
          );
        },
      );
      if (isConfirmed != true || !context.mounted) {
        return;
      }
    }
    showResult(context, viewModel.changeStatus(newStatus));
  }

  /// Builds the app bar and the sections of the order.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OrderDetailViewModel>();

    return StreamBuilder<OrderOverview?>(
      stream: viewModel.order,
      builder: (context, snapshot) {
        final order = snapshot.data;
        if (order == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Orden #${order.orderId}'),
            actions: [
              PopupMenuButton<OrderStatus>(
                tooltip: 'Cambiar estado',
                icon: const Icon(Icons.more_vert),
                onSelected: (newStatus) {
                  changeStatus(context, viewModel, newStatus);
                },
                itemBuilder: (context) {
                  return [
                    for (final status in OrderStatus.values)
                      PopupMenuItem(
                        value: status,
                        enabled: status != order.status,
                        child: Text(status.label),
                      ),
                  ];
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
            children: [
              _HeaderCard(order: order),
              _JobsSection(order: order),
              _PartsSection(order: order),
              _PaymentsSection(order: order),
            ],
          ),
        );
      },
    );
  }
}

/// Card with vehicle, client, mechanic, problem and the "advance status" button.
class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.order});

  final OrderOverview order;

  /// Builds one line with an icon and a text.
  Widget infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: mutedTextColor),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  /// Builds the card.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OrderDetailViewModel>();
    final nextStatus = order.status.nextStatus;

    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order.plate,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              StatusChip(status: order.status),
            ],
          ),
          Text('${order.brand} ${order.model}', style: const TextStyle(color: mutedTextColor)),
          const SizedBox(height: 8),
          infoRow(Icons.person_outline, '${order.clientName} · ${order.clientPhone}'),
          infoRow(Icons.build_outlined, order.mechanicName),
          infoRow(Icons.event_outlined, formatDate(order.entryDate)),
          const SizedBox(height: 16),
          const Text('Problema reportado', style: TextStyle(color: mutedTextColor, fontSize: 13)),
          const SizedBox(height: 4),
          Text(order.reportedProblem),
          if (nextStatus != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => showResult(context, viewModel.changeStatus(nextStatus)),
                child: Text('Pasar a: ${nextStatus.label}'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// One row inside a section: text on the left, amount and optional delete button.
class _LineRow extends StatelessWidget {
  const _LineRow({required this.title, required this.amountText, this.onDelete});

  final String title;
  final String amountText;
  final VoidCallback? onDelete;

  /// Builds the row.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Text(amountText, style: const TextStyle(fontWeight: FontWeight.w600)),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              color: mutedTextColor,
              visualDensity: VisualDensity.compact,
              onPressed: onDelete,
            )
          else
            const SizedBox(height: 40),
        ],
      ),
    );
  }
}

/// Section with the jobs done and their labor price.
class _JobsSection extends StatelessWidget {
  const _JobsSection({required this.order});

  final OrderOverview order;

  /// Asks for a description and a price, then adds the job.
  Future<void> addJob(BuildContext context) async {
    final values = await showFormDialog(
      context,
      title: 'Nuevo trabajo',
      fields: const [
        FormFieldSpec(label: 'Descripción', minLength: 3, maxLength: 100),
        FormFieldSpec(
          label: 'Mano de obra',
          kind: FieldKind.money,
          minValue: 0.01,
          maxValue: 1000000,
        ),
      ],
    );
    if (values == null || !context.mounted) {
      return;
    }
    final viewModel = context.read<OrderDetailViewModel>();
    showResult(context, viewModel.addJob(values[0], parseDecimal(values[1])!));
  }

  /// Builds the section.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OrderDetailViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Trabajos',
          onAdd: order.status.isOpen ? () => addJob(context) : null,
        ),
        StreamBuilder<List<OrderJob>>(
          stream: viewModel.jobs,
          builder: (context, snapshot) {
            final jobs = snapshot.data ?? [];
            if (jobs.isEmpty) {
              return const SoftCard(child: Text('Aún no hay trabajos', style: TextStyle(color: mutedTextColor)));
            }
            return SoftCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  for (final job in jobs)
                    _LineRow(
                      title: job.description,
                      amountText: formatMoney(job.laborPrice),
                      onDelete: order.status.isOpen
                          ? () => showResult(context, viewModel.deleteJob(job.id))
                          : null,
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

/// The part and quantity chosen in the "add part" dialog.
class PartSelection {
  const PartSelection(this.part, this.quantity);

  final Part part;
  final int quantity;
}

/// Dialog to choose a part and a quantity.
class _AddPartDialog extends StatefulWidget {
  const _AddPartDialog({required this.availableParts});

  final List<Part> availableParts;

  @override
  State<_AddPartDialog> createState() => _AddPartDialogState();
}

class _AddPartDialogState extends State<_AddPartDialog> {
  final formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController(text: '1');
  Part? selectedPart;

  /// Frees the text controller.
  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  /// Checks the quantity: a whole number, at least 1 and not more than the stock.
  String? validateQuantity(String? text) {
    final value = (text ?? '').trim();
    if (!RegExp(r'^\d+$').hasMatch(value) || value.length > 6) {
      return 'Escribe un número entero';
    }
    final quantity = int.parse(value);
    if (quantity < 1) {
      return 'Debe ser al menos 1';
    }
    if (selectedPart != null && quantity > selectedPart!.stock) {
      return 'Solo quedan ${selectedPart!.stock} en existencias';
    }
    return null;
  }

  /// Closes the dialog returning the choice, only if everything is valid.
  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final quantity = int.parse(quantityController.text.trim());
    Navigator.of(context).pop(PartSelection(selectedPart!, quantity));
  }

  /// Builds the dialog.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar repuesto'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Part>(
              isExpanded: true,
              decoration: fieldDecoration('Repuesto'),
              items: [
                for (final part in widget.availableParts)
                  DropdownMenuItem(
                    value: part,
                    child: Text('${part.name} (${part.stock})', overflow: TextOverflow.ellipsis),
                  ),
              ],
              validator: (part) => part == null ? 'Elige un repuesto' : null,
              onChanged: (part) => setState(() => selectedPart = part),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: fieldDecoration('Cantidad'),
              validator: validateQuantity,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: submit, child: const Text('Agregar')),
      ],
    );
  }
}

/// Section with the parts used in the order.
class _PartsSection extends StatelessWidget {
  const _PartsSection({required this.order});

  final OrderOverview order;

  /// Loads the parts with stock, shows the dialog and adds the chosen part.
  Future<void> addPart(BuildContext context) async {
    final viewModel = context.read<OrderDetailViewModel>();
    final availableParts = await viewModel.loadAvailableParts();
    if (!context.mounted) {
      return;
    }
    if (availableParts.isEmpty) {
      showMessage(context, 'No hay repuestos con existencias');
      return;
    }

    final selection = await showDialog<PartSelection>(
      context: context,
      builder: (context) => _AddPartDialog(availableParts: availableParts),
    );
    if (selection == null || !context.mounted) {
      return;
    }
    showResult(context, viewModel.addPart(selection.part, selection.quantity));
  }

  /// Builds the section.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OrderDetailViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Repuestos',
          onAdd: order.status.isOpen ? () => addPart(context) : null,
        ),
        StreamBuilder<List<UsedPart>>(
          stream: viewModel.usedParts,
          builder: (context, snapshot) {
            final usedParts = snapshot.data ?? [];
            if (usedParts.isEmpty) {
              return const SoftCard(child: Text('Aún no hay repuestos', style: TextStyle(color: mutedTextColor)));
            }
            return SoftCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  for (final used in usedParts)
                    _LineRow(
                      title: '${used.part.name} × ${used.line.quantity}',
                      amountText: formatMoney(used.line.quantity * used.line.unitPrice),
                      onDelete: order.status.isOpen
                          ? () => showResult(context, viewModel.removePart(used.line))
                          : null,
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Section with total, paid, balance and the list of payments.
class _PaymentsSection extends StatelessWidget {
  const _PaymentsSection({required this.order});

  final OrderOverview order;

  /// Asks for an amount (the balance is suggested) and registers the payment.
  Future<void> registerPayment(BuildContext context) async {
    final values = await showFormDialog(
      context,
      title: 'Registrar pago',
      fields: [
        FormFieldSpec(
          label: 'Monto',
          kind: FieldKind.money,
          minValue: 0.01,
          maxValue: double.parse(order.balance.toStringAsFixed(2)),
          initialValue: order.balance.toStringAsFixed(2),
        ),
      ],
    );
    if (values == null || !context.mounted) {
      return;
    }
    final viewModel = context.read<OrderDetailViewModel>();
    showResult(context, viewModel.addPayment(parseDecimal(values[0])!, order.balance));
  }

  /// Builds one line of the totals card.
  Widget amountRow(String label, double amount, {bool isBold = false, Color? color}) {
    final style = TextStyle(
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      fontSize: isBold ? 18 : 15,
      color: color,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(formatMoney(amount), style: style),
        ],
      ),
    );
  }

  /// Builds the section.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OrderDetailViewModel>();
    final canPay = order.status != OrderStatus.cancelled && !order.isPaid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Cobro'),
        SoftCard(
          child: Column(
            children: [
              amountRow('Total', order.total),
              amountRow('Pagado', order.paid),
              const Divider(height: 20),
              amountRow(
                'Pendiente',
                order.balance < 0 ? 0 : order.balance,
                isBold: true,
                color: order.isPaid ? const Color(0xFF2E9E5B) : dangerColor,
              ),
            ],
          ),
        ),
        if (canPay)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => registerPayment(context),
                child: const Text('Registrar pago'),
              ),
            ),
          ),
        StreamBuilder<List<Payment>>(
          stream: viewModel.payments,
          builder: (context, snapshot) {
            final payments = snapshot.data ?? [];
            return Column(
              children: [
                for (final payment in payments)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Pago del ${formatDate(payment.paidDate)}',
                            style: const TextStyle(color: mutedTextColor),
                          ),
                        ),
                        Text(formatMoney(payment.amount)),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
