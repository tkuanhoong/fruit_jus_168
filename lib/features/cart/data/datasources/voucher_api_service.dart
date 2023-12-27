import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/features/cart/data/models/selected_voucher.dart';

part "voucher_service.dart";

abstract class VoucherApiService {
  factory VoucherApiService(FirebaseFirestore db, FirebaseAuth auth) =
      _VoucherService;
  Future<SelectedVoucherModel> getVoucher(String voucherCode, int itemQuantity);
}
