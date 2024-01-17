import 'package:flutter/material.dart';
import 'package:fruit_jus_168/config/enum/order_status.dart';
import 'package:fruit_jus_168/core/utility/date_format_generator.dart';
import 'package:fruit_jus_168/features/order_details/presentation/widgets/detail_tile.dart';
import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';

class OrderStatusCard extends StatelessWidget {
  final OrderHistoryEntity order;
  const OrderStatusCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order Status",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  buildOrderStatusText(order.status),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: getOrderStatusColor(order.status).withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DetailTile(title: 'Order ID:', value: order.id, isId: true),
            const SizedBox(height: 16),
            DetailTile(
                title: "Order Time:",
                value: DateFormatGenerator.formatFirebaseTimestamp(
                  order.createdAt,
                )),
            const SizedBox(height: 16),
            DetailTile(
              title: order.type == 'delivery' ? "Delivery To:" : "Pickup from:",
              value: order.address,
            ),
            const SizedBox(height: 16),
            const DetailTile(
              title: 'Time Estimated:',
              value: '45 minutes',
            ),
          ],
        ),
      ),
    );
  }
}
