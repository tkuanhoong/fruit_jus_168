import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/order_details/domain/entities/order_details.dart';
import 'package:fruit_jus_168/features/order_details/domain/usecases/get_order_details.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  GetOrderDetailsUseCase getOrderDetailsUseCase;
  OrderDetailsBloc(this.getOrderDetailsUseCase) : super(OrderDetailsLoading()) {
    on<OrderDetailsRequested>((event, emit) async {
      emit(OrderDetailsLoading());
      try {
        final orderDetails = getOrderDetailsUseCase(params: event.orderId);
        await emit.forEach(orderDetails,
            onData: (data) => OrderDetailsLoaded(orderDetails: data));
      } catch (e) {
        emit(OrderDetailsError(message: e.toString()));
      }
    }, transformer: restartable());
  }
}
