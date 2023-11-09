import 'package:fruit_jus_168/core/usecases/usecase.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase implements UseCase<void, Map<String, dynamic>?> {
  final AuthRepository _authRepository;
  VerifyOtpUseCase(this._authRepository);

  @override
  Future<void> call({Map<String, dynamic>? params}) =>
      _authRepository.verifyOtp(
          verificationId: params!['verificationId']!,
          smsCode: params['smsCode']!);
}
