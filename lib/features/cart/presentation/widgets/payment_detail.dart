import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/theme/app_colors.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/voucher_bloc.dart';

class PaymentDetail extends StatelessWidget {
  const PaymentDetail({
    super.key,
    required this.amount,
    required this.subtotal,
    required this.deliveryFee,
    required this.grandTotal,
  });

  final int amount;
  final int subtotal;
  final int? deliveryFee;
  final int grandTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Amount'),
            Text('RM ${PriceConverter.fromInt(amount)}'),
          ],
        ),
        BlocBuilder<VoucherBloc, VoucherState>(
          builder: (context, state) {
            if (state is VoucherLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Voucher (${state.voucher!.voucherCode})'),
                  Text(
                      '- RM ${PriceConverter.fromInt(((state.voucher!.discount) * amount).toInt())}'),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Voucher'),
                  Text('- RM ${PriceConverter.fromInt((0 * amount).toInt())}'),
                ],
              );
            }
          },
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
            Text('RM ${PriceConverter.fromInt(subtotal)}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Delivery Fee'),
            Text('RM ${PriceConverter.fromInt(deliveryFee!)}'),
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
              'RM ${PriceConverter.fromInt(grandTotal)}',
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
