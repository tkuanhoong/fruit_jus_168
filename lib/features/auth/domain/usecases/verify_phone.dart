import 'package:fruit_jus_168/core/usecases/usecase.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';

class VerifyPhoneUseCase implements UseCase<void, String> {
  final AuthRepository _authRepository;
  VerifyPhoneUseCase(this._authRepository);

  @override
  Future<void> call({String? params}) => _authRepository.verifyPhone(params!);
}
