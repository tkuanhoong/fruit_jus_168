import 'dart:convert';

import 'package:fruit_jus_168/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.fullName,
    super.emailAddress,
    super.phoneNumber,
    super.dateOfBirth,
    super.userReferralCode,
    super.stamp,
    this.referrerHistory,
  });

  final List<String>? referrerHistory;
  // Fetching data from Firebase
  // DB -> JSON -> json.decode(JSON) -> Map -> UserModel.fromMap(Map) -> UserModel -> App

  // Saving data to Firebase
  // App -> UserModel -> toMap(UserModel) -> Map -> json.encode(Map) -> JSON -> DB

  // Function to edit User model
  UserModel copyWith({
    String? id,
    String? fullName,
    String? emailAddress,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? userReferralCode,
    int? stamp,
    List<String>? referrerHistory,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      userReferralCode: userReferralCode ?? this.userReferralCode,
      stamp: stamp ?? this.stamp,
      referrerHistory: referrerHistory ?? this.referrerHistory,
    );
  }

  // Convert UserModel to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'userRefferalCode': userReferralCode,
      'stamp': stamp,
      'referrerHistory': referrerHistory,
    };
  }

  // Convert Map to UserModel
  // Use the [factory] keyword when implementing a constructor that doesn’t always create a new instance of its class.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
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
      stamp: map['stamp'] != null ? map['stamp'] as int : null,
    );
  }

  // Convert UserModel to JSON
  String toJson() => json.encode(toMap());

  // Convert JSON from datasource to UserModel
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Convert UserEntity to UserModel
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      fullName: entity.fullName,
      emailAddress: entity.emailAddress,
      phoneNumber: entity.phoneNumber,
      dateOfBirth: entity.dateOfBirth,
      userReferralCode: entity.userReferralCode,
      stamp: entity.stamp,
    );
  }
}
