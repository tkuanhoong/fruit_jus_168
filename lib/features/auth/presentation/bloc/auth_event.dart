part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SaveUserInfo extends AuthEvent {
  final String fullName;
  final String email;
  final DateTime dateOfBirth;
  final String phoneNumber;
  final String referralCode;
  final String referrerUserId;
  const SaveUserInfo({
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.referralCode,
    required this.referrerUserId,
  });
  @override
  List<Object> get props => [fullName, email, dateOfBirth, phoneNumber, referralCode];
}

// When user requests to send OTP to user's phone number
class AuthOtpRequested extends AuthEvent {
  final String phoneNumber;

  const AuthOtpRequested({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

// When OTP is sent to user's phone number
class AuthOtpSent extends AuthEvent {
  final String verificationId;
  final int? token;
  const AuthOtpSent({required this.verificationId, required this.token});
  @override
  List<Object> get props => [verificationId];
}

// When user requests to verify OTP
class AuthOtpPendingVerified extends AuthEvent {
  final String otpCodeReceived;
  final String verificationId;
  const AuthOtpPendingVerified(
      {required this.otpCodeReceived, required this.verificationId});
  @override
  List<Object> get props => [otpCodeReceived, verificationId];
}

// When user failed to verify OTP
class AuthOtpFailed extends AuthEvent {
  final String error;
  const AuthOtpFailed({required this.error});
  @override
  List<Object> get props => [error];
}

// When user successfully verified OTP
class AuthVerified extends AuthEvent {
  final AuthCredential credential;
  const AuthVerified({required this.credential});
}

class LogOutRequested extends AuthEvent {}

class UserNameChange extends AuthEvent {
  final String fullName;
  const UserNameChange(this.fullName);
  @override
  List<Object> get props => [fullName];
}
