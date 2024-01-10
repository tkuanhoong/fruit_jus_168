part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  final Cart? cart;

  const CartState({this.cart = const Cart(items: [])});

  @override
  List<Object?> get props => [cart];
}

final class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  const CartLoaded({Cart? cart}) : super(cart: cart);
}

class PaymentSuccess extends CartState{
  
} 