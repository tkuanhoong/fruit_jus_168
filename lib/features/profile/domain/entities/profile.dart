import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? id;
  final String? fullName;
  final String? emailAddress;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? userReferralCode;
  final String? avatarURL;

  const ProfileEntity(
      {this.id,
      this.fullName,
      this.emailAddress,
      this.phoneNumber,
      this.dateOfBirth,
      this.userReferralCode,
      this.avatarURL});

  @override
  List<Object?> get props {
    return [
      id,
      fullName,
      emailAddress,
      phoneNumber,
      dateOfBirth,
      userReferralCode,
      avatarURL,
    ];
  }

  @override
  bool get stringify => true;
}
