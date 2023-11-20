import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? fullName;
  final String? emailAddress;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? userReferralCode;

  const UserEntity(
      {this.id,
      this.fullName,
      this.emailAddress,
      this.phoneNumber,
      this.dateOfBirth,
      this.userReferralCode, });

  @override
  List<Object?> get props {
    return [
      id,
      fullName,
      emailAddress,
      phoneNumber,
      dateOfBirth,
      userReferralCode
    ];
  }

  @override
  bool get stringify => true;
}
