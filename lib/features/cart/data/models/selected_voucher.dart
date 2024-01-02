import 'package:fruit_jus_168/features/cart/domain/entities/selected_voucher_entity.dart';

class SelectedVoucherModel extends SelectedVoucherEntity {
  const SelectedVoucherModel({
    required String voucherCode,
    required DateTime expiryDate,
    required int minItem,
    required double discount,
    required String imageURL,
    required bool isUsed,
  }) : super(
          voucherCode: voucherCode,
          expiryDate: expiryDate,
          minItem: minItem,
          discount: discount,
          imageURL: imageURL,
          isUsed: isUsed,
        );

  factory SelectedVoucherModel.fromJson(Map<String, dynamic> json) {
    return SelectedVoucherModel(
      voucherCode: json['code'],
      expiryDate: DateTime.parse(json['expiryDate']),
      minItem: json['minItem'],
      discount: json['discount'],
      imageURL: json['imageURL'],
      isUsed: json['isUsed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': voucherCode,
      'expiryDate': expiryDate.toIso8601String(),
      'minItem': minItem,
      'discount': discount,
      'imageURL': imageURL,
      'isUsed': isUsed,
    };
  }

  factory SelectedVoucherModel.fromEntity(SelectedVoucherEntity entity) {
    return SelectedVoucherModel(
      voucherCode: entity.voucherCode,
      expiryDate: entity.expiryDate,
      minItem: entity.minItem,
      discount: entity.discount,
      imageURL: entity.imageURL,
      isUsed: entity.isUsed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': voucherCode,
      'expiryDate': expiryDate.toIso8601String(),
      'minItem': minItem,
      'discount': discount,
      'imageURL': imageURL,
      'isUsed': isUsed,
    };
  }

  factory SelectedVoucherModel.fromMap(Map<String, dynamic> map) {
    return SelectedVoucherModel(
      voucherCode: map['code'],
      expiryDate: map['expiryDate'].toDate(),
      minItem: map['minItem'],
      discount: map['discount'],
      imageURL: map['imageURL'],
      isUsed: map['isUsed'],
    );
  }
}
