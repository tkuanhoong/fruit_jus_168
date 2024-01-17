import 'package:flutter/material.dart';
import 'dart:convert';

class ReferralHistoryPage extends StatelessWidget {
  const ReferralHistoryPage({Key? key, required this.referralHistory})
      : super(key: key);

  final List<Map<String, dynamic>> referralHistory;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> decodedReferralHistory =
        (jsonDecode(jsonEncode(referralHistory)) as List<dynamic>?)
            ?.cast<Map<String, dynamic>>() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Referral History'),
      ),
      body: Builder(
        builder: (context) {
          if (decodedReferralHistory.isEmpty) {
            return const Center(
              child: Text('No referral history available.'),
            );
          } else {
            print('Referral History: $decodedReferralHistory');
            return ListView.separated(
              itemCount: decodedReferralHistory.length,
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey,
                  height: 1,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Referral ${index + 1} - ${decodedReferralHistory[index]['referredFullName']}',
                  ),
                  // Add any other details or actions as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
