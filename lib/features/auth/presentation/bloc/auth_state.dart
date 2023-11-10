part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  //listen to auth state changes
  final User? firebaseUser;
  const AuthState({this.firebaseUser});

  @override
  List<Object?> get props => [firebaseUser];
}

final class AuthInitial extends AuthState {}

final class UserInfoSavedSuccess extends AuthState {
  const UserInfoSavedSuccess({User? firebaseUser})
      : super(firebaseUser: firebaseUser);
}

final class UserInfoSavedFailed extends AuthState {
  final String message;
  const UserInfoSavedFailed(this.message);
  @override
  List<Object> get props => [message];
}

class AuthLoadingState extends AuthState {}

class AuthCodeSentState extends AuthState {
  final String verificationId;
  const AuthCodeSentState({
    required this.verificationId,
  });
  @override
  List<Object> get props => [verificationId];
}

class AuthCodeVerifiedState extends AuthState {
  const AuthCodeVerifiedState({User? firebaseUser})
      : super(firebaseUser: firebaseUser);
}

class AuthErrorState extends AuthState {
  final String error;
  const AuthErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class AuthVerifyFailure extends AuthState {
  final String error;

  const AuthVerifyFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PhoneAuthVerifyFailure(error: $error)';
}

class LoggedOut extends AuthState {}
