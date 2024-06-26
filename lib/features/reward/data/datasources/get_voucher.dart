import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/features/reward/domain/entities/voucher.dart';

class GetVoucherFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VoucherEntity>> getVoucher() async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      CollectionReference userVoucherRef =
          _firestore.collection('users').doc(user?.uid).collection('vouchers');
      QuerySnapshot<Object?> querySnapshot =
          await userVoucherRef.where("isUsed", isNotEqualTo: true).get();

      //QuerySnapshot<Object?> querySnapshot = await userVoucherRef.get();

      List<VoucherEntity> voucher = querySnapshot.docs.map((doc) {
        // Convert timestamp to DateTime
        DateTime expiryDate = (doc['expiryDate'] as Timestamp).toDate();

        return VoucherEntity(
          voucherCode: doc['code'],
          expiryDate: expiryDate,
          discount: doc['discount'],
          imageURL: doc['imageURL'],
          minItem: doc['minItem'],
          isUsed: doc['isUsed'],
        );
      }).toList();

      return voucher;
    } catch (e) {
      throw Exception('Errors fetching voucher: $e');
    }
  }
}
