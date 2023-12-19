import 'package:equatable/equatable.dart';

import 'cart_product.dart';

class Cart extends Equatable {
  final List<CartProduct> items;

  const Cart({required this.items});

  int get totalPrice => items.fold(
        0,
        (previousValue, element) => previousValue + element.totalItemPrice,
      );

  int get totalItemsQuantity => items.fold(
        0,
        (previousValue, element) => previousValue + element.quantity!,
      );

  @override
  List<Object> get props => [items];

  Cart copyWith({List<CartProduct>? items}) {
    return Cart(items: items ?? this.items);
  }
}
