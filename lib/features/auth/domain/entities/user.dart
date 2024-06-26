import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? fullName;
  final String? emailAddress;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? userReferralCode;
  final int? stamp;

  const UserEntity({
    this.id,
    this.fullName,
    this.emailAddress,
    this.phoneNumber,
    this.dateOfBirth,
    this.userReferralCode,
    this.stamp,
  });

  @override
  List<Object?> get props {
    return [
      id,
      fullName,
      emailAddress,
      phoneNumber,
      dateOfBirth,
      userReferralCode,
      stamp
    ];
  }

  @override
  bool get stringify => true;
}
