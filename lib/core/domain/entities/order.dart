import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/cart_product.dart';

class OrderEntity extends Equatable {
  final String? id;
  final String type;
  final String address;
  final List<CartProduct> items;
  final int amount;
  final int total;
  final String status;
  final Timestamp createdAt;
  final int? deiveryFee;
  final int? discount;
  final String? note;
  final String? voucherCode;

  const OrderEntity({
    this.id,
    required this.type,
    required this.address,
    required this.items,
    required this.amount,
    required this.total,
    required this.status,
    required this.createdAt,
    this.deiveryFee,
    this.discount,
    this.note,
    this.voucherCode,
  });

  @override
  List<Object?> get props {
    return [
      id,
      type,
      address,
      items,
      amount,
      deiveryFee,
      discount,
      total,
      status,
      note,
      createdAt,
      voucherCode,
    ];
  }
}
