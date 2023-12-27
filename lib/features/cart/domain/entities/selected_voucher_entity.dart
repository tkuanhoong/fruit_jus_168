import 'package:fruit_jus_168/features/reward/domain/entities/coupon.dart';

class SelectedVoucherEntity extends Coupon {
  const SelectedVoucherEntity({
    required String code,
    required DateTime expiryDate,
    required int minItem,
    required double discount,
    required String imageURL,
  }) : super(
          code: code,
          expiryDate: expiryDate,
          minItem: minItem,
          discount: discount,
          imageURL: imageURL,
        );
}
