import 'package:equatable/equatable.dart';

class VoucherEntity extends Equatable {
  final String voucherCode;
  final DateTime expiryDate;
  final int minItem;
  final double discount;
  final String imageURL;
  final bool isUsed;

  // final boolean usedAt;

  const VoucherEntity({
    required this.voucherCode,
    required this.expiryDate,
    required this.discount,
    required this.imageURL,
    required this.minItem,
    required this.isUsed,
  });
  // @override
  // List<Object?> get props => [name];
  @override
  List<Object?> get props {
    return [
      voucherCode,
      expiryDate,
      minItem,
      discount,
      imageURL,
      isUsed,
    ];
  }
}
