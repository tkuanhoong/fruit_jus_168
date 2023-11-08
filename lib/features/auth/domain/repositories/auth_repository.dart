import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> saveUserInfo(UserEntity user);
  Future<void> verifyPhone(Map<String, dynamic> data);
  Future<void> verifyOtp(String verificationId, String smsCode);
}
