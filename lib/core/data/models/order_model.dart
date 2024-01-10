import 'package:fruit_jus_168/core/domain/entities/order.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.type,
    required super.address,
    required super.items,
    required super.amount,
    required super.total,
    required super.status,
    required super.createdAt,
    super.deiveryFee,
    super.discount,
    super.note,
    super.voucherCode,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      type: json['type'],
      address: json['address'],
      items: json['items'],
      amount: json['amount'],
      total: json['total'],
      status: json['status'],
      createdAt: json['createdAt'],
      deiveryFee: json['deiveryFee'],
      discount: json['discount'],
      note: json['note'],
      voucherCode: json['voucherId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'address': address,
      'items': items,
      'amount': amount,
      'total': total,
      'status': status,
      'createdAt': createdAt,
      'deiveryFee': deiveryFee,
      'discount': discount,
      'note': note,
      'voucherId': voucherCode,
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      type: entity.type,
      address: entity.address,
      items: entity.items,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'address': address,
      'items': items,
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

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      type: map['type'],
      address: map['address'],
      items: map['items'],
      amount: map['amount'],
      total: map['total'],
      status: map['status'],
      createdAt: map['createdAt'],
      deiveryFee: map['deiveryFee'],
      discount: map['discount'],
      note: map['note'],
      voucherCode: map['voucherCode'],
    );
  }
}
