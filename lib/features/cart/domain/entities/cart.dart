import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/selected_voucher_entity.dart';

import 'cart_product.dart';

class Cart extends Equatable {
  final String? fulfillMethod;
  final String? address;
  final List<CartProduct> items;
  final SelectedVoucherEntity? voucher;
  final int? deliveryFee;

  const Cart({
    this.fulfillMethod,
    this.address,
    required this.items,
    this.voucher,
  }) : deliveryFee = fulfillMethod == "delivery" ? 500 : 0;

  int get totalPrice => items.fold(
        0,
        (previousValue, element) => previousValue + element.totalItemPrice,
      );

  int get totalItemsQuantity => items.fold(
        0,
        (previousValue, element) => previousValue + element.quantity!,
      );

  int get subTotal =>
      (totalPrice * (1 - (voucher != null ? voucher!.discount : 0))).toInt();

  int get grandTotal => (subTotal + deliveryFee!).toInt();

  @override
  List<Object?> get props =>
      [items, voucher, deliveryFee, fulfillMethod, address];

  Cart copyWith({
    List<CartProduct>? items,
    SelectedVoucherEntity? voucher,
    String? fulfillMethod,
    String? address,
    int? deliveryFee,
  }) {
    return Cart(
      items: items ?? this.items,
      voucher: voucher,
      fulfillMethod: fulfillMethod ?? this.fulfillMethod,
      address: address ?? this.address,
    );
  }
}
