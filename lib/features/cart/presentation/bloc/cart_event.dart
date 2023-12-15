part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddProduct extends CartEvent {
  final Product product;
  final int quantity;
  final String preference;

  const AddProduct(
      {required this.product,
      required this.quantity,
      required this.preference});

  @override
  List<Object> get props => [product, quantity, preference];
}

class UpdateProduct extends CartEvent {
  final Product product;

  const UpdateProduct(this.product);
}

class RemoveProduct extends CartEvent {
  final Product product;

  const RemoveProduct(this.product);

  @override
  List<Object> get props => [product];
}
