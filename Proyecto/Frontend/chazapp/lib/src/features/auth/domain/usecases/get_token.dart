import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_local_repository.dart';

class GetTokenUseCase extends UseCase<String?, void> {
  final AuthLocalRepository _authLocalRepository;

  GetTokenUseCase(this._authLocalRepository);

  @override
  Future<String?> call({void params}) async {
    return await _authLocalRepository.getToken();
  }
}
