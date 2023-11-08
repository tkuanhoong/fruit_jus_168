part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}
//////////////////////////////////////////////////////

final class AuthInitial extends AuthState {}
//////////////////////////////////////////////////////

final class UserInfoSavedSuccess extends AuthState {}

final class UserInfoSavedFailed extends AuthState {
  final String message;
  const UserInfoSavedFailed(this.message);
  @override
  List<Object> get props => [message];
}

//////////////////////////////////////////////////////
class AuthLoadingState extends AuthState {}

class AuthCodeSentState extends AuthState {
  final String verificationId;
  const AuthCodeSentState({
    required this.verificationId,
  });
  @override
  List<Object> get props => [verificationId];

  @override
  String toString() =>
      'PhoneAuthCodeSentSuccess(verificationId: $verificationId)';
}

class AuthCodeVerifiedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  const AuthErrorState(this.error);
}

/////////////////////////////////////////////////////////////////
/// User is verified and logged in
class AuthLoggedInState extends AuthState {
  final User firebaseUser;
  const AuthLoggedInState(this.firebaseUser);
}

class AuthLoggedOutState extends AuthState {}

////////////////////////////////////////////////////////////////
class AuthVerifyFailure extends AuthState {
  final String error;

  const AuthVerifyFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PhoneAuthVerifyFailure(error: $error)';
}
