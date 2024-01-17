import 'package:fruit_jus_168/features/order_details/data/datasources/order_details_api_service.dart';
import 'package:fruit_jus_168/features/order_details/data/models/order_details_model.dart';
import 'package:fruit_jus_168/features/order_details/domain/repositories/order_details_repository.dart';

class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
  final OrderDetailsApiService _orderDetailsApiService;
  OrderDetailsRepositoryImpl(this._orderDetailsApiService);
  @override
  Stream<OrderDetailsModel> getOrderDetails(String orderId) {
    return _orderDetailsApiService.getOrderDetails(orderId);
  }
}
