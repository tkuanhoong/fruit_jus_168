import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/cart/domain/entities/selected_voucher_entity.dart';
import 'package:fruit_jus_168/features/cart/domain/usecases/get_voucher.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  GetVoucherUseCase getVoucherUseCase;
  VoucherBloc(this.getVoucherUseCase) : super(VoucherInitial()) {
    on<ApplyVoucher>(
      (event, emit) async {
        try {
          final voucher = await getVoucherUseCase(
              params: event.voucherCode, itemQuantity: event.itemQuantity);
          emit(
            VoucherLoaded(voucher: voucher),
          );
        } catch (e) {
          emit(VoucherError(message: e.toString()));
        }
      },
    );
    on<ResetVoucherState>((event, emit) => emit(VoucherInitial()));
    on<RemoveVoucher>(
        (event, emit) => emit(const VoucherRemoved(voucher: null)));
  }
}
