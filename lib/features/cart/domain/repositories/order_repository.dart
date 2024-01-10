import 'package:fruit_jus_168/core/domain/entities/order.dart';

abstract class OrderRepository {
  Future<void> makeOrder(OrderEntity orderEntity);
}
