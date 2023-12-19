import 'package:fruit_jus_168/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();

  Future<void> uploadAvatar(String imagePath);
}
