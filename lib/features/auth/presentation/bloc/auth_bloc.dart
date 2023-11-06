import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/auth/domain/entities/user.dart';
import 'package:fruit_jus_168/features/auth/domain/usecases/save_user_info.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SaveUserInfoUseCase _saveUserInfoUseCase;
  AuthBloc(this._saveUserInfoUseCase) : super(AuthInitial()) {
    on<SaveUserInfo>(onSaveUserInfo);
  }
  Future<void> onSaveUserInfo(
      SaveUserInfo event, Emitter<AuthState> emit) async {
    try {
      final user = UserEntity(
        fullName: event.fullName,
        emailAddress: event.email,
        dateOfBirth: event.dateOfBirth,
        phoneNumber: event.phoneNumber,
      );
      await _saveUserInfoUseCase(params: user);
      emit(UserInfoSavedSuccess());
    } catch (e) {
      emit(UserInfoSavedFailed(e.toString()));
    }
  }
}
