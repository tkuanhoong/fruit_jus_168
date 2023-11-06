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
  const SaveUserInfo({
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.phoneNumber,
  });
  @override
  List<Object> get props => [fullName, email, dateOfBirth, phoneNumber];
}
