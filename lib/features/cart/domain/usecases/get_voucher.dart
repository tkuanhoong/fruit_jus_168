import 'package:fruit_jus_168/core/usecases/usecase.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/selected_voucher_entity.dart';
import 'package:fruit_jus_168/features/cart/domain/repositories/voucher_repository.dart';

class GetVoucherUseCase extends UseCase<SelectedVoucherEntity, String> {
  final VoucherRepository _voucherRepository;

  GetVoucherUseCase(this._voucherRepository);

  @override
  Future<SelectedVoucherEntity> call(
      {String? params, int? itemQuantity}) async {
    return _voucherRepository.getVoucher(params!, itemQuantity!);
  }
}
