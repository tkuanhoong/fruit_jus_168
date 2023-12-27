part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
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
  final int cartIndex;
  final int quantity;
  final String preference;

  const UpdateProduct({
    required this.cartIndex,
    required this.quantity,
    required this.preference,
  });

  @override
  List<Object> get props => [cartIndex, quantity, preference];
}

class RemoveProduct extends CartEvent {
  final int cartIndex;

  const RemoveProduct({required this.cartIndex});

  @override
  List<Object> get props => [cartIndex];
}

class ClearCart extends CartEvent {}

class VoucherChange extends CartEvent {
  final SelectedVoucherEntity? voucher;

  const VoucherChange({this.voucher});

  @override
  List<Object?> get props => [voucher];
}

class VoucherDelete extends CartEvent {
  final SelectedVoucherEntity? voucher;

  const VoucherDelete({this.voucher});

  @override
  List<Object?> get props => [voucher];
}
