import 'package:flutter/material.dart';
import 'package:fruit_jus_168/features/reward/presentation/pages/tab/CouponTab.dart';
import 'package:fruit_jus_168/features/reward/presentation/pages/tab/stampTab.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Reward',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    //Container Color
                    color: Color(0XFF20941C),
                    //shape
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: TabBar(
                        //Word Color
                        labelColor: Colors.black87,
                        labelStyle: TextStyle(),
                        //Underline color
                        indicatorColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: 'Stamps',
                            icon: Icon(Icons.badge_rounded),
                          ),
                          Tab(
                            text: 'Coupon',
                            icon: Icon(Icons.card_giftcard_rounded),
                          )
                        ],
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: TabBarView(children: [
                  stampTab(),
                  CouponTab(),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
