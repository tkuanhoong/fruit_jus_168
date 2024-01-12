part of 'order_details_bloc.dart';

sealed class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

final class OrderDetailsLoading extends OrderDetailsState {}

final class OrderDetailsLoaded extends OrderDetailsState {
  final OrderDetailsEntity orderDetails;
  const OrderDetailsLoaded({required this.orderDetails});

  @override
  List<Object> get props => [orderDetails];
}

final class OrderDetailsError extends OrderDetailsState {
  final String message;
  const OrderDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
