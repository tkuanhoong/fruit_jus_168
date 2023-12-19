import 'package:fruit_jus_168/core/usecases/usecase.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';

class VerifyPhoneUseCase implements UseCase<void, Map<String, dynamic>> {
  final AuthRepository _authRepository;
  VerifyPhoneUseCase(this._authRepository);

  @override
  Future<void> call({Map<String, dynamic>? params}) => _authRepository.verifyPhone(params!);
}
