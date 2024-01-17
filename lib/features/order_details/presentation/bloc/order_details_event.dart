part of 'order_details_bloc.dart';

sealed class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class OrderDetailsRequested extends OrderDetailsEvent {
  final String orderId;
  const OrderDetailsRequested({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
