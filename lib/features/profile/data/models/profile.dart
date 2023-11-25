import 'dart:convert';

import 'package:fruit_jus_168/features/profile/domain/entities/profile.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    super.id,
    super.fullName,
    super.emailAddress,
    super.phoneNumber,
    super.dateOfBirth,
    super.userReferralCode,
    super.avatarURL,
  });

  // Function to edit Profile model
  ProfileModel copyWith({
    String? id,
    String? fullName,
    String? emailAddress,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? userReferralCode,
    String? avatarURL,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      userReferralCode: userReferralCode ?? this.userReferralCode,
      avatarURL: avatarURL ?? this.avatarURL,
    );
  }

  // Convert ProfileModel to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'userRefferalCode': userReferralCode,
      'avatarURL': avatarURL,
    };
  }

  // Convert Map to ProfileModel
  // Use the [factory] keyword when implementing a constructor that doesn’t always create a new instance of its class.
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] != null ? map['id'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      emailAddress:
          map['emailAddress'] != null ? map['emailAddress'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int)
          : null,
      userReferralCode: map['userRefferalCode'] != null
          ? map['userRefferalCode'] as String
          : null,
      avatarURL: map['avatarURL'] != null ? map['avatarURL'] as String : null,
    );
  }

  // Convert ProfileModel to JSON
  String toJson() => json.encode(toMap());

  // Convert JSON from datasource to ProfileModel
  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Convert ProfileEntity to ProfileModel
  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      fullName: entity.fullName,
      emailAddress: entity.emailAddress,
      phoneNumber: entity.phoneNumber,
      dateOfBirth: entity.dateOfBirth,
      userReferralCode: entity.userReferralCode,
      avatarURL: entity.avatarURL,
    );
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      fullName: fullName,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      userReferralCode: userReferralCode,
      avatarURL: avatarURL,
    );
  }
}
