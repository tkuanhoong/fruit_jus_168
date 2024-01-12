import 'package:fruit_jus_168/core/usecases/usecase.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';

class UpdateUserInfoUseCase extends UseCase<void, String> {
  final AuthRepository _authRepository;

  UpdateUserInfoUseCase(this._authRepository);

  @override
  Future<void> call({String? params}) async {
    return await _authRepository.updateUserInfo(params!);
  }
}
