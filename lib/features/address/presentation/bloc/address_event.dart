part of 'address_bloc.dart';

abstract class AddressEvent {}

class GetAddresses extends AddressEvent {
  final String? addressId;
  GetAddresses({
    this.addressId,
  });
}

class AddAddress extends AddressEvent {
  final String name;
  final String unit;
  final String streetName;
  final String city;
  final String postalCode;
  final String state;
  final String country;
  final String note;
  AddAddress({
    required this.name,
    required this.unit,
    required this.streetName,
    required this.city,
    required this.postalCode,
    required this.state,
    required this.country,
    required this.note,
  });
}

class EditAddress extends AddressEvent {
  final String id;
  final String name;
  final String unit;
  final String streetName;
  final String city;
  final String postalCode;
  final String state;
  final String country;
  final String note;
  final bool isDefault;
  EditAddress({
    required this.id,
    required this.name,
    required this.unit,
    required this.streetName,
    required this.city,
    required this.postalCode,
    required this.state,
    required this.country,
    required this.note,
    required this.isDefault,
  });
}

class DeleteAddress extends AddressEvent {
  final String addressId;
  DeleteAddress({
    required this.addressId,
  });
}

class UpdateDefaultAddress extends AddressEvent {
  final String addressId;
  UpdateDefaultAddress({
    required this.addressId,
  });
}
