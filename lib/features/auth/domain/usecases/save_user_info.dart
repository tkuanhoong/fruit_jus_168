import 'package:fruit_jus_168/core/usecases/usecase.dart';
import 'package:fruit_jus_168/features/auth/domain/entities/user.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';

class SaveUserInfoUseCase implements UseCase<void, UserEntity> {
  final AuthRepository _authRepository;
  SaveUserInfoUseCase(this._authRepository);

  @override
  Future<void> call({UserEntity? params}) =>
      _authRepository.saveUserInfo(params!);
}
