import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderHistoryEntity extends Equatable {
  final String id;
  final String type;
  final String address;
  final int amount;
  final int total;
  final String status;
  final Timestamp createdAt;
  final int? deiveryFee;
  final int? discount;
  final String? note;
  final String? voucherCode;

  const OrderHistoryEntity({
    required this.id,
    required this.type,
    required this.address,
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
  List<Object?> get props => [
        id,
        type,
        address,
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
