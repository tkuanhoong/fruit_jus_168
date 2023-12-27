import 'package:fruit_jus_168/features/cart/domain/entities/selected_voucher_entity.dart';

class SelectedVoucherModel extends SelectedVoucherEntity {
  const SelectedVoucherModel({
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

  factory SelectedVoucherModel.fromJson(Map<String, dynamic> json) {
    return SelectedVoucherModel(
      code: json['code'],
      expiryDate: DateTime.parse(json['expiryDate']),
      minItem: json['minItem'],
      discount: json['discount'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'expiryDate': expiryDate.toIso8601String(),
      'minItem': minItem,
      'discount': discount,
      'imageURL': imageURL,
    };
  }

  factory SelectedVoucherModel.fromEntity(SelectedVoucherEntity entity) {
    return SelectedVoucherModel(
      code: entity.code,
      expiryDate: entity.expiryDate,
      minItem: entity.minItem,
      discount: entity.discount,
      imageURL: entity.imageURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'expiryDate': expiryDate.toIso8601String(),
      'minItem': minItem,
      'discount': discount,
      'imageURL': imageURL,
    };
  }

  factory SelectedVoucherModel.fromMap(Map<String, dynamic> map) {
    return SelectedVoucherModel(
      code: map['code'],
      expiryDate: map['expiryDate'].toDate(),
      minItem: map['minItem'],
      discount: map['discount'],
      imageURL: map['imageURL'],
    );
  }
}
