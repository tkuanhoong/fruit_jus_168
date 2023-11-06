part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class UserInfoSavedSuccess extends AuthState {}

final class UserInfoSavedFailed extends AuthState {
  final String message;
  const UserInfoSavedFailed(this.message);
  @override
  List<Object> get props => [message];
}
