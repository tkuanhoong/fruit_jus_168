import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_jus_168/features/auth/data/models/user.dart';

part 'auth_service.dart';

abstract class AuthApiService {
  factory AuthApiService(FirebaseAuth auth, FirebaseFirestore db) =
      _AuthService;
  Future<void> verifyPhone(Map<String, dynamic>phoneNumber);
  Future<void> storeUserInfo(UserModel user);
  Future<void> verifyOtp(String verificationId, String smsCode);
}
