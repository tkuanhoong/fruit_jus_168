import 'package:fruit_jus_168/features/auth/domain/entities/user.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> saveUserProfile(UserEntity user) async {
    // TODO: implement saveUserProfile
    print(user);
  }
}
