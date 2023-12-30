import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/features/reward/data/models/voucher.dart';

class NewVoucherGeneratorService {
  Future<void> createNewVoucher() async {
    //get current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference userVoucherRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('voucher');

      VoucherModel newVoucher = VoucherModel(
        voucherCode: 'NEW001',
        expiryDate: DateTime.now().add(const Duration(days: 30)),
        discount: 0.2,
        minItem: 1,
        imageURL: 'assets/images/logo.png',
      );
      //Convert the coupon data to map
      Map<String, dynamic> voucherData = newVoucher.toMap();

      //add coupon data to the coupon collection firebase
      await userVoucherRef.add(voucherData);
    } else {
      print('User not signed in');
    }
  }
}
