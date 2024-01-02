import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  final String code;
  final DateTime expiryDate;
  final int minItem;
  final double discount;
  final String imageURL;

  const Coupon({
    required this.code,
    required this.expiryDate,
    required this.minItem,
    required this.discount,
    required this.imageURL,
  });

  @override
  List<Object?> get props {
    return [
      code,
      expiryDate,
      minItem,
      discount,
      imageURL,
    ];
  }
}
