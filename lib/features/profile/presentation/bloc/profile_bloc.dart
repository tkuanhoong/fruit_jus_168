import 'package:fruit_jus_168/features/profile/domain/entities/profile.dart';
import 'package:fruit_jus_168/features/profile/domain/usecases/get_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/features/profile/domain/usecases/upload_avatar.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UploadAvatarUseCase uploadAvatarUseCase;

  ProfileBloc(
      {required this.getProfileUseCase, required this.uploadAvatarUseCase})
      : super(ProfileLoading()) {
    on<LoadProfile>((event, emit) async {
      try {
        final ProfileEntity profile = await getProfileUseCase.call();
        emit(ProfileLoaded(profile: profile));
      } catch (e) {
        emit(ProfileError(errorMessage: 'Failed to load profile.'));
      }
    });

    on<UploadAvatar>((event, emit) async {
      emit(ProfileLoading());
      try {
        await uploadAvatarUseCase.call(event.imagePath);
        final ProfileEntity profile = await getProfileUseCase.call();
        emit(ProfileLoaded(profile: profile));
      } catch (e) {
        emit(ProfileError(errorMessage: 'Failed to upload avatar.'));
      }
    });
  }
}
