import 'package:fruit_jus_168/core/usecases/stream_usecase.dart';
import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';
import 'package:fruit_jus_168/features/order_history/domain/repositories/order_history_repository.dart';

class GetOrderListUseCase
    implements StreamUseCase<List<OrderHistoryEntity>, void> {
  final OrderHistoryRepository _orderHistoryRepository;

  GetOrderListUseCase(this._orderHistoryRepository);

  @override
  Stream<List<OrderHistoryEntity>> call({void params}) =>
      _orderHistoryRepository.getOrderList();
}
