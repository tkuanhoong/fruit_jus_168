import 'package:firebase_auth_platform_interface/src/providers/phone_auth.dart';
import 'package:fruit_jus_168/core/usecases/usecase.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase implements UseCase<void, String> {
  final AuthRepository _authRepository;
  VerifyOtpUseCase(this._authRepository);

  @override
  Future<void> call({String? params}) =>
      _authRepository.verifyOtp(params!, params!);
}
