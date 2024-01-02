import 'package:fruit_jus_168/features/cart/domain/entities/selected_voucher_entity.dart';

abstract class VoucherRepository {
  Future<SelectedVoucherEntity> getVoucher(
      String voucherCode, int itemQuantity);
}
