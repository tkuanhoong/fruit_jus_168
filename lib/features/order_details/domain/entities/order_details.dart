import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/cart_product.dart';
import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';

class OrderDetailsEntity extends Equatable {
  final OrderHistoryEntity order;
  final List<CartProduct> items;

  const OrderDetailsEntity({required this.order, required this.items});

  @override
  List<Object> get props => [order, items];
}
