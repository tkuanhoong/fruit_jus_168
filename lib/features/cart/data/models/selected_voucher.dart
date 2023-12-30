import 'package:fruit_jus_168/features/cart/domain/entities/selected_voucher_entity.dart';

class SelectedVoucherModel extends SelectedVoucherEntity {
  const SelectedVoucherModel({
    required String voucherCode,
    required DateTime expiryDate,
    required int minItem,
    required double discount,
    required String imageURL,
  }) : super(
          voucherCode: voucherCode,
          expiryDate: expiryDate,
          minItem: minItem,
          discount: discount,
          imageURL: imageURL,
        );

  factory SelectedVoucherModel.fromJson(Map<String, dynamic> json) {
    return SelectedVoucherModel(
      voucherCode: json['voucherCode'],
      expiryDate: DateTime.parse(json['expiryDate']),
      minItem: json['minItem'],
      discount: json['discount'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucherCode': voucherCode,
      'expiryDate': expiryDate.toIso8601String(),
      'minItem': minItem,
      'discount': discount,
      'imageURL': imageURL,
    };
  }

  factory SelectedVoucherModel.fromEntity(SelectedVoucherEntity entity) {
    return SelectedVoucherModel(
      voucherCode: entity.voucherCode,
      expiryDate: entity.expiryDate,
      minItem: entity.minItem,
      discount: entity.discount,
      imageURL: entity.imageURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'voucherCode': voucherCode,
      'expiryDate': expiryDate.toIso8601String(),
      'minItem': minItem,
      'discount': discount,
      'imageURL': imageURL,
    };
  }

  factory SelectedVoucherModel.fromMap(Map<String, dynamic> map) {
    return SelectedVoucherModel(
      voucherCode: map['voucherCode'],
      expiryDate: map['expiryDate'].toDate(),
      minItem: map['minItem'],
      discount: map['discount'],
      imageURL: map['imageURL'],
    );
  }
}
