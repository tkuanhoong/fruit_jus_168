import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/features/reward/data/models/voucher.dart';

class NewVoucherGeneratorService {
  Future<void> createNewVoucher(String userId, {String? referralCode}) async {
    // Check if a referral code is provided and not empty
    if (referralCode != null && referralCode.isNotEmpty) {
      // Referral code is provided, generate and add voucher
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        CollectionReference userVoucherRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('vouchers');

        VoucherModel newVoucher = VoucherModel(
          voucherCode: 'NEW001',
          expiryDate: DateTime.now().add(const Duration(days: 30)),
          discount: 0.2,
          minItem: 1,
          imageURL: 'assets/images/logo.png',
          isUsed: false,
        );
        // Convert the voucher data to a map
        Map<String, dynamic> voucherData = newVoucher.toMap();

        // Add voucher data to the voucher collection in Firebase
        await userVoucherRef.add(voucherData);
      } else {
        print('User not signed in');
      }
    } else {
      // No referral code provided, print a message (no voucher generated)
      print('No voucher generated.');
    }
  }
}
