import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? id;
  final String? name;
  final String? unit;
  final String? streetName;
  final String? city;
  final String? postalCode;
  final String? state;
  final String? country;
  final String? note;
  final bool? isDefault;

  const AddressEntity({
    this.id,
    this.name,
    this.unit,
    this.streetName,
    this.city,
    this.postalCode,
    this.state,
    this.country,
    this.note,
    this.isDefault,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      unit,
      streetName,
      city,
      postalCode,
      state,
      country,
      note,
      isDefault,
    ];
  }

  @override
  bool get stringify => true;
}
