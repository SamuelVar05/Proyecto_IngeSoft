import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_local_repository.dart';

class DeleteTokenUseCase extends UseCase {
  final AuthLocalRepository _authLocalRepository;

  DeleteTokenUseCase(this._authLocalRepository);

  @override
  Future<void> call({void params}) async {
    await _authLocalRepository.deleteToken();
  }
}