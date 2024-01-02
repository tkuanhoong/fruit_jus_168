part of 'address_bloc.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressesLoading extends AddressState {}

class AddressesLoaded extends AddressState {
  final List<AddressEntity> addresses;
  final AddressEntity? address;

  AddressesLoaded({required this.addresses, this.address});
}

class AddressError extends AddressState {
  final String errorMessage;

  AddressError({required this.errorMessage});
}

class DefaultAddressUpdated extends AddressState {
  final AddressEntity address;
  DefaultAddressUpdated({required this.address});
}
