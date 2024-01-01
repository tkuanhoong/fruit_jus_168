import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_jus_168/features/address/domain/entities/address.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    super.id,
    super.name,
    // super.unit,
    // super.streetName,
    super.address,
    super.city,
    super.postalCode,
    super.state,
    super.country,
    super.note,
    super.isDefault,
    super.createdAt,
    super.latitude,
    super.longitude,
  });

  // Function to edit Address model
  AddressModel copyWith({
    String? id,
    String? name,
    // String? unit,
    // String? streetName,
    String? address,
    String? city,
    String? postalCode,
    String? state,
    String? country,
    String? note,
    bool? isDefault,
    Timestamp? createdAt,
    double? latitude,
    double? longitude,
  }) {
    return AddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      // unit: unit ?? this.unit,
      // streetName: streetName ?? this.streetName,
      address: address ?? this.address,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      state: state ?? this.state,
      country: country ?? this.country,
      note: note ?? this.note,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  // Convert AddressModel to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      // 'unit': unit,
      // 'streetName': streetName,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'state': state,
      'country': country,
      'note': note,
      'isDefault': isDefault,
      'createdAt': createdAt,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Convert Map to AddressModel
  // Use the [factory] keyword when implementing a constructor that doesn’t always create a new instance of its class.
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      // unit: map['unit'] != null ? map['unit'] as String : null,
      // streetName:
      //     map['streetName'] != null ? map['streetName'] as String : null,
      address: map['address'] != null ? (map['address'] as String) : null,
      city: map['city'] != null ? (map['city'] as String) : null,
      postalCode:
          map['postalCode'] != null ? map['postalCode'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      isDefault: map['isDefault'] != null ? map['isDefault'] as bool : null,
      createdAt:
          map['createdAt'] != null ? map['createdAt'] as Timestamp : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
    );
  }

  // Convert AddressModel to JSON
  String toJson() => json.encode(toMap());

  // Convert JSON from datasource to AddressModel
  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Convert AddressEntity to AddressModel
  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      name: entity.name,
      // unit: entity.unit,
      // streetName: entity.streetName,
      address: entity.address,
      city: entity.city,
      postalCode: entity.postalCode,
      state: entity.state,
      country: entity.country,
      note: entity.note,
      isDefault: entity.isDefault,
      createdAt: entity.createdAt,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }

  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      name: name,
      // unit: unit,
      // streetName: streetName,
      city: city,
      address: address,
      postalCode: postalCode,
      state: state,
      country: country,
      note: note,
      isDefault: isDefault,
      createdAt: createdAt,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
