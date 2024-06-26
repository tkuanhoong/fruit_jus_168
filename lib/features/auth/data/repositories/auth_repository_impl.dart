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
  Future<void> verifyOtp(
      {required String verificationId, required String smsCode}) async {
    await _authApiService.verifyOtp(verificationId, smsCode);
  }

  @override
  Future<void> logOut() async {
    await _authApiService.logOut();
  }
  
  @override
  Future<void> updateUserInfo(String fullName) async {
    await _authApiService.updateUserInfo(fullName);
  }
}
