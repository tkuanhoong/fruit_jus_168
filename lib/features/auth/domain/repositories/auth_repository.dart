import 'package:fruit_jus_168/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> saveUserProfile(UserEntity user);
}
