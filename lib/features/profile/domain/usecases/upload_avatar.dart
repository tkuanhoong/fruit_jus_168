import 'package:fruit_jus_168/features/profile/domain/repositories/profile_repository.dart';

class UploadAvatarUseCase {
  final ProfileRepository _profileRepository;

  UploadAvatarUseCase(this._profileRepository);

  @override
  Future<void> call(String imagePath) async {
    return await _profileRepository.uploadAvatar(imagePath);
  }
}
