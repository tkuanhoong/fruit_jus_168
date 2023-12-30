import 'package:flutter/material.dart';
import 'package:fruit_jus_168/core/utility/date_format_generator.dart';
import 'package:fruit_jus_168/features/reward/domain/entities/voucher.dart';

class CouponDetailPage extends StatefulWidget {
  const CouponDetailPage({super.key});

  @override
  State<CouponDetailPage> createState() => _CouponDetailPageState();
}

class _CouponDetailPageState extends State<CouponDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final coupon = ModalRoute.of(context)!.settings.arguments as VoucherEntity;
    final expiryDate = DateFormatGenerator.getFormattedDateTime(
        coupon.expiryDate.toIso8601String(), 'dd - MM - yyyy');
    final voucherDiscount = coupon.discount * 100.toInt();
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coupon Detail'),
      ),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
            child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(
                  coupon.imageURL,
                )),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                'Discount : '),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                style: const TextStyle(
                  fontSize: 15,
                ),
                voucherDiscount.toString()),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                'Expired Date : '),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                style: const TextStyle(
                  fontSize: 15,
                ),
                expiryDate),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                'Minimum Item : '),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                style: const TextStyle(
                  fontSize: 15,
                ),
                coupon.minItem.toString()),
          ),
        ],
      ),
    );
  }
}
