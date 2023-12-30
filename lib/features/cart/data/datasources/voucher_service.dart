part of 'voucher_api_service.dart';

class _VoucherService implements VoucherApiService {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  _VoucherService(this._db, this._auth);

  @override
  Future<SelectedVoucherModel> getVoucher(
      String voucherCode, int itemQuantity) async {
    final userId = _auth.currentUser!.uid;
    try {
      final snapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('voucher')
          .where('voucherCode', isEqualTo: voucherCode)
          .get();
      if (snapshot.docs.isEmpty) {
        throw Exception('Voucher not found!');
      }
      final voucher = SelectedVoucherModel.fromMap(snapshot.docs.first.data());
      if (voucher.expiryDate.isBefore(DateTime.now())) {
        throw Exception('Voucher has expired!');
      }
      if (itemQuantity < voucher.minItem) {
        throw Exception(
            'Minimum ${voucher.minItem} item(s) is required to use this voucher!');
      }
      return voucher;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
