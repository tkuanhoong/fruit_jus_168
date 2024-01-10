import 'package:fruit_jus_168/features/reward/domain/entities/voucher.dart';

class SelectedVoucherEntity extends VoucherEntity {
  const SelectedVoucherEntity({
    required String voucherCode,
    required DateTime expiryDate,
    required int minItem,
    required double discount,
    required String imageURL,
    bool? isUsed,
  }) : super(
          voucherCode: voucherCode,
          expiryDate: expiryDate,
          minItem: minItem,
          discount: discount,
          imageURL: imageURL,
          isUsed: isUsed,
        );
}
