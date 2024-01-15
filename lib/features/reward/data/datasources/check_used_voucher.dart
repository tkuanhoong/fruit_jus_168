import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckUsedVoucherService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> useVoucher(String voucherCode) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      CollectionReference userVoucherRef =
          _firestore.collection('users').doc(user?.uid).collection('vouchers');

      // Find the document with the given voucherCode
      QuerySnapshot<Object?> querySnapshot =
          await userVoucherRef.where('code', isEqualTo: voucherCode).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update the document to mark the voucher as used
        await userVoucherRef.doc(querySnapshot.docs.first.id).update({
          'isUsed': true,
        });
      }
    } catch (e) {
      throw Exception('Error marking voucher as used: $e');
    }
  }
}
