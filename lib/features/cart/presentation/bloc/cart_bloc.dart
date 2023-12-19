import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/cart.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/cart_product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartLoading()) {
    on<LoadCart>(
      (event, emit) {
        emit(CartLoaded(cart: state.cart ?? const Cart(items: [])));
      },
    );
    on<AddProduct>((event, emit) {
      final addingProduct = CartProduct(
        id: event.product.id,
        name: event.product.name,
        price: event.product.price,
        description: event.product.description,
        imageUrl: event.product.imageUrl,
        quantity: event.quantity,
        preference: event.preference,
      );
      List<CartProduct> items = List.from(state.cart!.items);
      // if exist same product
      // if exist same product and preference
      if (items.any((element) =>
          element.id == addingProduct.id &&
          element.preference == addingProduct.preference)) {
        items = items.map((e) {
          if (e.id == addingProduct.id &&
              e.preference == addingProduct.preference) {
            return e.copyWith(quantity: e.quantity! + addingProduct.quantity!);
          }
          return e;
        }).toList();
      } else {
        // add product for other case
        items.add(addingProduct);
      }
      emit(
        CartLoaded(
          cart: Cart(
            items: items,
          ),
        ),
      );
    });
    on<UpdateProduct>((event, emit) {
      List<CartProduct> items = List.from(state.cart!.items);

      // find the item
      final updatingItemIndex = event.cartIndex;
      CartProduct updatingItem = items[updatingItemIndex];
      // update the item
      updatingItem = updatingItem.copyWith(
          quantity: event.quantity, preference: event.preference);

      items[updatingItemIndex] = updatingItem;

      emit(CartLoaded(
        cart: Cart(items: items),
      ));
    });

    on<RemoveProduct>((event, emit) {
      emit(CartLoaded(
          cart: Cart(
              items: List.from(state.cart!.items)..removeAt(event.cartIndex))));
    });
  }
}
