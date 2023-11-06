import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_jus_168/features/auth/data/models/user.dart';
part 'auth_service.dart';

abstract class AuthApiService {
  factory AuthApiService(FirebaseFirestore db) = _AuthService;
  Future<void> storeUserInfo(UserModel user);
}
