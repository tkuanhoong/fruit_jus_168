import 'package:flutter/material.dart';
import 'package:fruit_jus_168/core/utility/date_format_generator.dart';
import 'package:fruit_jus_168/features/reward/data/datasources/get_voucher.dart';
import 'package:fruit_jus_168/features/reward/domain/entities/voucher.dart';
import 'package:fruit_jus_168/features/reward/presentation/pages/voucherdetail.dart';

class VoucherTab extends StatefulWidget {
  const VoucherTab({super.key});

  @override
  _VoucherTabState createState() => _VoucherTabState();
}

class _VoucherTabState extends State<VoucherTab> {
  //function
  late Future<List<VoucherEntity>> _voucherListFuture;
  //call the function from the class
  final GetVoucherFirestoreService _firestoreService =
      GetVoucherFirestoreService();

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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No vouchers found');
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
                        color: Color.fromARGB(255, 20, 175, 14),
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
                            builder: (context) => const VoucherDetailPage(),
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
                                "${(vouchers[index].discount * 100).toInt()}% ",
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
