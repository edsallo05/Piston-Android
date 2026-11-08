import 'package:flutter/material.dart';

import '../../data/database.dart';
import '../../models/models.dart';
import '../order_detail_screen.dart';
import 'common.dart';

/// Color that represents each order status.
Color statusColor(OrderStatus status) {
  switch (status) {
    case OrderStatus.received:
      return const Color(0xFF8A8A8E);
    case OrderStatus.diagnosing:
      return warningColor;
    case OrderStatus.repairing:
      return accentColor;
    case OrderStatus.readyForPickup:
      return const Color(0xFF2E9E5B);
    case OrderStatus.delivered:
      return const Color(0xFFB0B0B5);
    case OrderStatus.cancelled:
      return dangerColor;
  }
}

/// A colored dot followed by the status name.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final OrderStatus status;

  /// Builds the dot and the text.
  @override
  Widget build(BuildContext context) {
    final color = statusColor(status);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          status.label,
          style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ],
    );
  }
}

/// Card that summarizes one order in a list. Opens the order when tapped.
class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.order});

  final OrderOverview order;

  /// Builds the card.
  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: () => openOrderDetail(context, order.orderId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order.plate,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              StatusChip(status: order.status),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${order.brand} ${order.model} · ${order.clientName}',
            style: const TextStyle(color: mutedTextColor),
          ),
          const SizedBox(height: 8),
          Text(order.reportedProblem, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${order.mechanicName} · ${formatDate(order.entryDate)}',
                  style: const TextStyle(color: mutedTextColor, fontSize: 13),
                ),
              ),
              if (order.status != OrderStatus.cancelled && !order.isPaid)
                Text(
                  'Debe ${formatMoney(order.balance)}',
                  style: const TextStyle(
                    color: dangerColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
