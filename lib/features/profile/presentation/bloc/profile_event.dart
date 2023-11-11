part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UploadAvatar extends ProfileEvent {
  final String imagePath;

  UploadAvatar({required this.imagePath});
}
