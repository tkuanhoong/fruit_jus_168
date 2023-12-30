import 'package:flutter/material.dart';
import 'package:fruit_jus_168/core/utility/date_format_generator.dart';
import 'package:fruit_jus_168/features/reward/data/datasources/get_voucher.dart';
import 'package:fruit_jus_168/features/reward/domain/entities/voucher.dart';
import 'package:fruit_jus_168/features/reward/presentation/pages/coupondetail.dart';

class CouponTab extends StatefulWidget {
  CouponTab({super.key});

  @override
  _CouponTabState createState() => _CouponTabState();
}

class _CouponTabState extends State<CouponTab> {
  late Future<List<VoucherEntity>> _voucherListFuture;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _voucherListFuture = _firestoreService.getVoucher();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VoucherEntity>>(
      future: _voucherListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No vouchers found');
        } else {
          List<VoucherEntity> vouchers = snapshot.data!;
          return ListView.builder(
            itemCount: vouchers.length,
            itemBuilder: (BuildContext context, int index) {
              final expiryDate = vouchers[index].expiryDate.toIso8601String();
              final formattedExpiryDate =
                  DateFormatGenerator.getFormattedDateTime(
                      expiryDate, 'dd - MM - yyyy');

              return Column(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0XFF20941C),
                      ),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.all(20),
                    child: InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CouponDetailPage(),
                            settings: RouteSettings(
                              arguments: vouchers[index],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Code : ${vouchers[index].voucherCode}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(vouchers[index].imageURL),
                          ),
                          ListTile(
                            title: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Discount",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            subtitle: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${vouchers[index].discount * 100}% ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Align(
                              alignment: Alignment.center,
                              child: Text('Expiry Date : $formattedExpiryDate'),
                            ),
                            subtitle: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  'Minimum Item : ${vouchers[index].minItem}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
