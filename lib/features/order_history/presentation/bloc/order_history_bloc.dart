import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';
import 'package:fruit_jus_168/features/order_history/domain/usecases/get_order_list.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final GetOrderListUseCase _getOrderList;
  OrderHistoryBloc(this._getOrderList) : super(OrderHistoryLoading()) {
    on<OrderHistoryRequested>((event, emit) async {
      emit(OrderHistoryLoading());
      try {
        final orderList = _getOrderList();
        await emit.forEach(orderList,
            onData: (data) => OrderHistoryLoaded(data));
      } catch (e) {
        emit(OrderHistoryError(e.toString()));
      }
    }, transformer: restartable());
  }
}
