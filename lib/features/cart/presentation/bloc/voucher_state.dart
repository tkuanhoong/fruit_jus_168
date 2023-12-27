part of 'voucher_bloc.dart';

sealed class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object> get props => [];
}

final class VoucherInitial extends VoucherState {}

class VoucherLoaded extends VoucherState {
  final SelectedVoucherEntity? voucher;

  const VoucherLoaded({this.voucher});
}

class VoucherRemoved extends VoucherState {
  final SelectedVoucherEntity? voucher;

  const VoucherRemoved({this.voucher});
}

class VoucherError extends VoucherState {
  final String message;

  const VoucherError({required this.message});
}
