import 'package:fruit_jus_168/features/order_details/domain/entities/order_details.dart';

abstract class OrderDetailsRepository {
  Stream<OrderDetailsEntity> getOrderDetails(String orderId);
}
