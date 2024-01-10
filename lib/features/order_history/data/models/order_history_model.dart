import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';

class OrderHistoryModel extends OrderHistoryEntity {
  const OrderHistoryModel({
    required super.id,
    required super.type,
    required super.address,
    required super.amount,
    required super.total,
    required super.status,
    required super.createdAt,
    super.deiveryFee,
    super.discount,
    super.note,
    super.voucherCode,
  });

  // toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'address': address,
      'amount': amount,
      'total': total,
      'status': status,
      'createdAt': createdAt,
      'deiveryFee': deiveryFee,
      'discount': discount,
      'note': note,
      'voucherCode': voucherCode,
    };
  }

  // fromMap
  factory OrderHistoryModel.fromMap(Map<String, dynamic> map) {
    return OrderHistoryModel(
      id: map['id'] as String,
      type: map['type'] as String,
      address: map['address'] as String,
      amount: map['amount'] as int,
      total: map['total'] as int,
      status: map['status'] as String,
      createdAt: map['createdAt'] as Timestamp,
      deiveryFee: map['deiveryFee'] != null ? map['deiveryFee'] as int : null,
      discount: map['discount'] != null ? map['discount'] as int : null,
      note: map['note'] != null ? map['note'] as String : null,
      voucherCode:
          map['voucherCode'] != null ? map['voucherCode'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryModel.fromJson(String source) =>
      OrderHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory OrderHistoryModel.fromEntity(OrderHistoryEntity entity) {
    return OrderHistoryModel(
      id: entity.id,
      type: entity.type,
      address: entity.address,
      amount: entity.amount,
      total: entity.total,
      status: entity.status,
      createdAt: entity.createdAt,
      deiveryFee: entity.deiveryFee,
      discount: entity.discount,
      note: entity.note,
      voucherCode: entity.voucherCode,
    );
  }
}
