part of 'voucher_bloc.dart';

sealed class VoucherEvent extends Equatable {
  const VoucherEvent();

  @override
  List<Object> get props => [];
}

class ApplyVoucher extends VoucherEvent {
  final String voucherCode;
  final int itemQuantity;

  const ApplyVoucher({required this.voucherCode, required this.itemQuantity});

  @override
  List<Object> get props => [voucherCode];
}

class ResetVoucherState extends VoucherEvent {}

class RemoveVoucher extends VoucherEvent {}
