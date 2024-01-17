import 'package:fruit_jus_168/core/domain/entities/order.dart';
import 'package:fruit_jus_168/core/usecases/usecase.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/order_repository.dart';

class MakeOrderUseCase extends UseCase<void, OrderEntity> {
  final OrderRepository _orderRepository;

  MakeOrderUseCase(this._orderRepository);

  @override
  Future<void> call({OrderEntity? params}) async {
    await _orderRepository.makeOrder(params!);
  }
}
