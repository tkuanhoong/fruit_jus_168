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
  // final String unit;
  // final String streetName;
  final String address;
  final String city;
  final String postalCode;
  final String state;
  final String country;
  final String note;
  final double latitude;
  final double longitude;
  AddAddress({
    required this.name,
    // required this.unit,
    // required this.streetName,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.state,
    required this.country,
    required this.note,
    required this.latitude,
    required this.longitude,
  });
}

class EditAddress extends AddressEvent {
  final String id;
  final String name;
  // final String unit;
  // final String streetName;
  final String address;
  final String city;
  final String postalCode;
  final String state;
  final String country;
  final String note;
  final bool isDefault;
  final Timestamp createdAt;
  final double latitude;
  final double longitude;
  EditAddress({
    required this.id,
    required this.name,
    // required this.unit,
    // required this.streetName,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.state,
    required this.country,
    required this.note,
    required this.isDefault,
    required this.createdAt,
    required this.latitude,
    required this.longitude,
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
