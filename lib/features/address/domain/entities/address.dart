import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? id;
  final String? name;
  // final String? unit;
  // final String? streetName;
  final String? address;
  final String? city;
  final String? postalCode;
  final String? state;
  final String? country;
  final String? note;
  final bool? isDefault;
  final Timestamp? createdAt;
  final double? latitude;
  final double? longitude;

  const AddressEntity({
    this.id,
    this.name,
    // this.unit,
    // this.streetName,
    this.address,
    this.city,
    this.postalCode,
    this.state,
    this.country,
    this.note,
    this.isDefault,
    this.createdAt,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      // unit,
      // streetName,
      address,
      city,
      postalCode,
      state,
      country,
      note,
      isDefault,
      createdAt,
      latitude,
      longitude,
    ];
  }

  @override
  bool get stringify => true;
}
