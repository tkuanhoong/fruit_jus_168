import 'package:fruit_jus_168/core/usecases/usecase.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';

class LogOutUseCase implements UseCase<void, void> {
  final AuthRepository _authRepository;
  LogOutUseCase(this._authRepository);

  @override
  Future<void> call({void params}) => _authRepository.logOut();
}
