import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fruit_jus_168/core/utility/date_format_generator.dart';
import 'package:fruit_jus_168/core/utility/price_converter.dart';
import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';

class OrderCard extends StatelessWidget {
  final OrderHistoryEntity order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 15),
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 5,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: InkWell(
            onTap: () {},
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 270,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      height: 50,
                      color: const Color.fromARGB(80, 158, 158, 158),
                      child: Center(
                          child: Text("Delivery Status: ${order.status}")),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'ID : ',
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: order.id,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            // const Text("21 Dec 2023 20:30"),
                            Text(
                              DateFormatGenerator.formatFirebaseTimestamp(
                                  order.createdAt),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(top: 10, bottom: 1),
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: const FittedBox(
                            child: Image(
                              width: 25,
                              height: 50,
                              alignment: Alignment.center,
                              image: AssetImage('assets/images/receipt.png'),
                            ),
                          ),
                          onTap: () {},
                          onLongPress: () {},
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 15, bottom: 5, right: 15, left: 5),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Material(
                            color: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Ink(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 15, left: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors
                                        .black, // Change this color to the color you want
                                    width:
                                        1, // Change this width to the width you want
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                child: const Center(
                                    child: Text(
                                  "Reorder",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                    height: 30,
                    indent: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width +
                        20),
                    endIndent: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width +
                        20),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const FittedBox(
                        clipBehavior: Clip.hardEdge,
                        child: Image(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          image: AssetImage('assets/images/smalldelivery.png'),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 150,
                            margin: const EdgeInsets.only(left: 20, bottom: 3),
                            child: Text(
                              order.type == "delivery"
                                  ? 'Delivery To:'
                                  : "Pickup From",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              width: 150,
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 3),
                              child: AutoSizeText(
                                order.address,
                                minFontSize: 9,
                                maxFontSize: 16,
                                maxLines: 2,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              margin:
                                  const EdgeInsets.only(left: 10, bottom: 3),
                              child: const Text(
                                'Total: ',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin:
                                  const EdgeInsets.only(left: 10, bottom: 3),
                              child: Text(
                                'RM ${PriceConverter.fromInt(order.total)}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "See More Details",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
