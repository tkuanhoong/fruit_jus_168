import 'package:flutter/material.dart';
import 'package:fruit_jus_168/core/utility/date_format_generator.dart';
import 'package:fruit_jus_168/features/reward/domain/entities/coupon.dart';

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
    final coupon = ModalRoute.of(context)!.settings.arguments as Coupon;
    final expiryDate = DateFormatGenerator.getFormattedDateTime(
        coupon.expiryDate.toIso8601String(), 'dd - MM - yyyy');
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupon Detail'),
      ),
      body: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.asset(coupon.imageURL),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                'Discount : '),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                  fontSize: 15,
                ),
                coupon.discount.toString()),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                'Expired Date : '),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                  fontSize: 15,
                ),
                expiryDate),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                'Minimum Item : '),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                style: TextStyle(
                  fontSize: 15,
                ),
                coupon.minItem.toString()),
          ),
        ],
      ),
    );
  }
}
