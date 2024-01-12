import 'package:fruit_jus_168/core/usecases/stream_usecase.dart';
import 'package:fruit_jus_168/features/order_details/domain/entities/order_details.dart';
import 'package:fruit_jus_168/features/order_details/domain/repositories/order_details_repository.dart';

class GetOrderDetailsUseCase
    implements StreamUseCase<OrderDetailsEntity, String> {
  final OrderDetailsRepository _repository;

  GetOrderDetailsUseCase(this._repository);

  @override
  Stream<OrderDetailsEntity> call({String? params}) =>
      _repository.getOrderDetails(params!);
}
