import 'package:fruit_jus_168/features/cart/data/datasources/voucher_api_service.dart';
import 'package:fruit_jus_168/features/cart/data/models/selected_voucher.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/voucher_repository.dart';

class VoucherRepositoryImpl implements VoucherRepository {
  final VoucherApiService _voucherApiService;

  VoucherRepositoryImpl(this._voucherApiService);

  @override
  Future<SelectedVoucherModel> getVoucher(
      String voucherCode, int itemQuantity) async {
    return await _voucherApiService.getVoucher(voucherCode, itemQuantity);
  }
}
