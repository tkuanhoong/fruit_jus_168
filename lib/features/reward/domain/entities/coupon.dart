import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  final DateTime expiryDate;
  final int minItem, discount;
  final String imageURL;

  Coupon(
      {required this.expiryDate,
      required this.minItem,
      required this.discount,
      required this.imageURL});

  // @override
  // List<Object?> get props => [name];
  @override
  List<Object?> get props {
    return [
      expiryDate,
      minItem,
      discount,
      imageURL,
    ];
  }
}
