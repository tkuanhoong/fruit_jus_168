import 'package:fruit_jus_168/core/data/models/order_model.dart';
import 'package:fruit_jus_168/core/domain/entities/order.dart';
import 'package:fruit_jus_168/core/data/datasources/order_api_service.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiService _orderApiService;

  OrderRepositoryImpl(this._orderApiService);

  @override
  Future<void> makeOrder(OrderEntity orderEntity) async {
    return _orderApiService.makeOrder(OrderModel.fromEntity(orderEntity));
  }
}
