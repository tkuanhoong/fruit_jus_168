import 'package:flutter/material.dart';
import 'package:fruit_jus_168/config/theme/app_colors.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';

class OrderPayment extends StatelessWidget {
  final OrderHistoryEntity order;
  const OrderPayment({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Amount'),
            Text('RM ${PriceConverter.fromInt(order.amount)}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            order.voucherCode == null
                ? const Text('Voucher')
                : Text('Voucher $order.voucherCode}(${order.voucherCode})'),
            Text('- RM ${PriceConverter.fromInt(order.discount ?? 0)}'),
          ],
        ),
        Divider(
          indent: MediaQuery.of(context).size.width * 0.7,
          color: Colors.grey,
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Subtotal'),
            Text(
                'RM ${PriceConverter.fromInt(order.amount - (order.discount ?? 0))}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Delivery Fee'),
            Text('RM ${PriceConverter.fromInt(order.deiveryFee ?? 0)}'),
          ],
        ),
        Divider(
          indent: MediaQuery.of(context).size.width * 0.7,
          color: Colors.grey,
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Grand Total',
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'RM ${PriceConverter.fromInt(order.total)}',
              style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
