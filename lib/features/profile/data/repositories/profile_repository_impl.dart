import 'package:fruit_jus_168/features/profile/data/datasources/profile_datasource.dart';
import 'package:fruit_jus_168/features/profile/data/models/profile.dart';
import 'package:fruit_jus_168/features/profile/domain/entities/profile.dart';
import 'package:fruit_jus_168/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSource;

  ProfileRepositoryImpl({required this.profileDataSource});

  @override
  Future<ProfileEntity> getProfile() async {
    try {
      final ProfileModel profileModel =
          await profileDataSource.getProfileData();
      return profileModel;
    } catch (e) {
      // Handle the exception or throw it as needed
      throw Exception('Failed to get profile: $e');
    }
  }

  @override
  Future<void> uploadAvatar(String imagePath) async {
    try {
      await profileDataSource.uploadAvatar(imagePath);
    } catch (e) {
      throw Exception('Failed to upload avatar: $e');
    }
  }
}
