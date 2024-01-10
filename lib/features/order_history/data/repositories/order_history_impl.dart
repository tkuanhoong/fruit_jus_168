import 'package:fruit_jus_168/features/order_history/data/datasources/order_history_api_service.dart';
import 'package:fruit_jus_168/features/order_history/data/models/order_history_model.dart';
import 'package:fruit_jus_168/features/order_history/domain/repositories/order_history_repository.dart';

class OrderHistoryRepositoryImpl implements OrderHistoryRepository {
  final OrderHistoryApiService _orderHistoryApiService;
  OrderHistoryRepositoryImpl(this._orderHistoryApiService);
  @override
  Stream<List<OrderHistoryModel>> getOrderList() =>
      _orderHistoryApiService.getOrderList();
}
