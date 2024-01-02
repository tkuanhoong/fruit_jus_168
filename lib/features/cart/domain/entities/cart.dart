import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/selected_voucher_entity.dart';

import 'cart_product.dart';

class Cart extends Equatable {
  final String? fulfillMethod;
  final String? address;
  final List<CartProduct> items;
  final SelectedVoucherEntity? voucher;

  const Cart({
    this.fulfillMethod,
    this.address,
    required this.items,
    this.voucher,
  });

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

  int get grandTotal => (subTotal + deliveryFee).toInt();

  int get deliveryFee =>
      (fulfillMethod == "delivery" && totalItemsQuantity > 1) ? 500 : 0;

  @override
  List<Object?> get props => [items, voucher, fulfillMethod, address];

  Cart copyWith({
    List<CartProduct>? items,
    SelectedVoucherEntity? voucher,
    String? fulfillMethod,
    String? address,
  }) {
    return Cart(
      items: items ?? this.items,
      voucher: voucher,
      fulfillMethod: fulfillMethod ?? this.fulfillMethod,
      address: address ?? this.address,
    );
  }
}
