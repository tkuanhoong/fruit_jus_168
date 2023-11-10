import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_jus_168/features/auth/domain/entities/user.dart';
import 'package:fruit_jus_168/features/auth/domain/usecases/log_out.dart';
import 'package:fruit_jus_168/features/auth/domain/usecases/save_user_info.dart';
import 'package:fruit_jus_168/features/auth/domain/usecases/verify_otp.dart';
import 'package:fruit_jus_168/features/auth/domain/usecases/verify_phone.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SaveUserInfoUseCase _saveUserInfoUseCase;
  final VerifyPhoneUseCase _verifyPhoneUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final LogOutUseCase _logOutUseCase;
  AuthBloc(this._saveUserInfoUseCase, this._verifyPhoneUseCase,
      this._verifyOtpUseCase, this._logOutUseCase)
      : super(AuthInitial()) {
    on<SaveUserInfo>(onSaveUserInfo);
    on<AuthOtpRequested>(sendOtp);

    // After receiving the otp, When user clicks on verify otp button then this event will be fired
    on<AuthOtpPendingVerified>(verifyOTP);

    // When the firebase sends the code to the user's phone, this event will be fired
    on<AuthOtpSent>((event, emit) =>
        emit(AuthCodeSentState(verificationId: event.verificationId)));

    on<LogOutRequested>(onLogOut);
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
      emit(UserInfoSavedSuccess(
          firebaseUser: FirebaseAuth.instance.currentUser));
    } catch (e) {
      emit(UserInfoSavedFailed(e.toString()));
    }
  }

  FutureOr<void> sendOtp(
      AuthOtpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      await _verifyPhoneUseCase(params: {
        'phoneNumber': event.phoneNumber,
        'verificationFailed': (error) {
          emit(AuthVerifyFailure(error: error.toString()));
        },
        'codeSent': (verificationId, token) {
          add(AuthOtpSent(
            verificationId: verificationId,
            token: token,
          ));
        },
      });
    } catch (e) {
      emit(AuthVerifyFailure(error: e.toString()));
    }
  }

  FutureOr<void> verifyOTP(
      AuthOtpPendingVerified event, Emitter<AuthState> emit) async {
    try {
      await _verifyOtpUseCase(params: {
        'verificationId': event.verificationId,
        'smsCode': event.otpCodeReceived,
      });
      emit(AuthCodeVerifiedState(
          firebaseUser: FirebaseAuth.instance.currentUser));
    } catch (e) {
      emit(AuthVerifyFailure(error: e.toString()));
    }
  }

  Future<void> onLogOut(event, emit) async {
    await _logOutUseCase();
    emit(LoggedOut());
  }
}
