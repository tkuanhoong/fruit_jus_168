import 'package:fruit_jus_168/features/order_history/domain/entities/order_history.dart';

abstract class OrderHistoryRepository {
  Stream<List<OrderHistoryEntity>> getOrderList();
}
