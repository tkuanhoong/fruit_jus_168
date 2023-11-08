import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/features/auth/data/datasources/auth_api_service.dart';
import 'package:fruit_jus_168/features/auth/data/models/user.dart';
import 'package:fruit_jus_168/features/auth/domain/entities/user.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);

  @override
  Future<void> saveUserInfo(UserEntity user) async {
    await _authApiService.storeUserInfo(UserModel.fromEntity(user));
  }

  @override
  Future<void> verifyPhone(Map<String, dynamic> data) async {
    await _authApiService.verifyPhone(data);
  }

  @override
  Future<void> verifyOtp(String verificationId, String smsCode) async {
    await _authApiService.verifyOtp(verificationId, smsCode);
  }
}
