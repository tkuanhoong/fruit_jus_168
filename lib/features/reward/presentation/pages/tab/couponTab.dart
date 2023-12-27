import 'package:flutter/material.dart';
import 'package:fruit_jus_168/core/utility/date_format_generator.dart';

import 'package:fruit_jus_168/features/reward/domain/entities/coupon.dart';
import 'package:fruit_jus_168/features/reward/presentation/pages/coupondetail.dart';

class couponTab extends StatelessWidget {
  couponTab({super.key});
  final List<Coupon> list1 = [
    Coupon(
        code: "RTTTTT",
        expiryDate: DateTime.now(),
        minItem: 2,
        discount: 15,
        imageURL: 'assets/images/logo.png'),
    Coupon(
        code: "RTTTTT",
        expiryDate: DateTime.now(),
        minItem: 1,
        discount: 20,
        imageURL: 'assets/images/slider_1.jpg'),
    Coupon(
        code: "RTTTTT",
        expiryDate: DateTime.now(),
        minItem: 4,
        discount: 35,
        imageURL: 'assets/images/discount1.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list1.length,
      itemBuilder: (BuildContext context, int index) {
        final expiryDate = DateFormatGenerator.getFormattedDateTime(
            list1[index].expiryDate.toIso8601String(), 'dd - MM - yyyy');
        //var image = Image.asset(list1[index].imageURL);
        return Column(
          children: [
            Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0XFF20941C),
                  ),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(20),
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () {
                    // GoRouter.of(context).push('/coupon-detail');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CouponDetailPage(),
                        // Pass the arguments as part of the RouteSettings. The
                        // CouponDetailPage( reads the arguments from these settings.
                        settings: RouteSettings(
                          arguments: list1[index],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(list1[index].imageURL),
                      ),
                      ListTile(
                        title: Align(
                          alignment: Alignment.center,
                          child: Text(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              "Discount"),
                        ),
                        subtitle: Align(
                          alignment: Alignment.center,
                          child: Text(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              list1[index].discount.toString() + "% "),
                        ),
                      ),
                      ListTile(
                        //leading: Image.asset(),
                        title: Text('Expiry Date : $expiryDate'),
                        subtitle:
                            Text('Minimum Item : ${list1[index].minItem}'),
                      ),
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }
}
