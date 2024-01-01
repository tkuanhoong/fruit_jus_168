import 'dart:convert';

import 'package:fruit_jus_168/features/reward/domain/entities/voucher.dart';

class VoucherModel extends VoucherEntity {
  const VoucherModel({
    required super.voucherCode,
    required super.discount,
    required super.expiryDate,
    required super.imageURL,
    required super.minItem,
    required super.isUsed,
  });

  VoucherModel copyWith({
    required String voucherCode,
    required double discount,
    required DateTime expiryDate,
    required String imageURL,
    required int minItem,
    required bool isUsed,
  }) {
    return VoucherModel(
      voucherCode: voucherCode,
      discount: discount,
      expiryDate: expiryDate,
      imageURL: imageURL,
      minItem: minItem,
      isUsed: isUsed,
    );
  }

  // Convert UserModel to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'voucherCode': voucherCode,
      'expiryDate': expiryDate,
      'discount': discount,
      'imageURL': imageURL,
      'minItem': minItem,
      'isUsed': isUsed,
    };
  }

  // Convert Map to VoucherModel
  // Use the [factory] keyword when implementing a constructor that doesn’t always create a new instance of its class.
  factory VoucherModel.fromMap(Map<String, dynamic> map) {
    return VoucherModel(
      voucherCode: map['voucherCode'],
      expiryDate: map['expiryDate'],
      discount: map['discount'],
      imageURL: map['imageURL'],
      minItem: map['minItem'],
      isUsed: map['isUsed'],
    );  
  }

  //Convert VoucherModel to JSON
  String toJson() => json.encode(toMap());

  // Convert JSON from datasource to UserModel
  factory VoucherModel.fromJson(String source) =>
      VoucherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Convert UserEntity to UserModel
  factory VoucherModel.fromEntity(VoucherEntity entity) {
    return VoucherModel(
      voucherCode: entity.voucherCode,
      expiryDate: entity.expiryDate,
      discount: entity.discount,
      imageURL: entity.imageURL,
      minItem: entity.minItem,
      isUsed: entity.isUsed,
    );
  }
}
