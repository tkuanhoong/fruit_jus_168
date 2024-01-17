import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/core/domain/entities/order.dart';
import 'package:fruit_jus_168/core/domain/entities/product.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/cart.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/cart_product.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/selected_voucher_entity.dart';
import 'package:fruit_jus_168/features/cart/domain/usecases/make_order.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  MakeOrderUseCase makeOrderUseCase;
  CartBloc(this.makeOrderUseCase) : super(const CartLoading()) {
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
      final updatedCart = state.cart!.copyWith(items: items);
      emit(
        CartLoaded(
          cart: updatedCart,
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
      final updatedCart = state.cart!.copyWith(items: items);
      emit(
        CartLoaded(
          cart: updatedCart,
        ),
      );
    });

    on<RemoveProduct>((event, emit) {
      List<CartProduct> items = List.from(state.cart!.items)
        ..removeAt(event.cartIndex);
      final updatedCart = state.cart!.copyWith(items: items);
      emit(
        CartLoaded(
          cart: updatedCart,
        ),
      );
    });

    on<ClearCart>((event, emit) {
      emit(const CartLoaded(
          cart: Cart(
              items: [], voucher: null, fulfillMethod: null, address: null)));
    });

    on<VoucherChange>(
      (event, emit) {
        emit(
          CartLoaded(
            cart: state.cart!.copyWith(voucher: event.voucher),
          ),
        );
      },
    );

    on<VoucherDelete>((event, emit) {
      Cart updatedCart =
          state.cart!.copyWith(voucher: null); // Setting voucher to null
      emit(
        CartLoaded(
          cart: updatedCart,
        ),
      );
    });

    on<FullfillmentChange>((event, emit) {
      Cart updatedCart = state.cart!.copyWith(
          fulfillMethod: event.deliveryMethod, address: event.address);
      emit(CartLoaded(cart: updatedCart));
    });

    on<MakeOrder>((event, emit) async {
      Cart cartData = event.cart;
      OrderEntity order = OrderEntity(
          type: cartData.fulfillMethod!,
          address: cartData.address!,
          items: cartData.items,
          amount: cartData.totalPrice,
          total: cartData.grandTotal,
          status: 'pending',
          createdAt: Timestamp.now(),
          deiveryFee: cartData.deliveryFee,
          discount: cartData.voucher != null
              ? (cartData.totalPrice * cartData.voucher!.discount).toInt()
              : 0,
          note: event.remark,
          voucherCode:
              cartData.voucher != null ? cartData.voucher!.voucherCode : null);
      await makeOrderUseCase(params: order);
      emit(PaymentSuccess());
    });
  }
}
