import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_local_repository.dart';

class SaveTokenUseCase extends UseCase<void, String> {
  final AuthLocalRepository _authLocalRepository;

  SaveTokenUseCase(this._authLocalRepository);

  @override
  Future<void> call({String? params}) async {
    if (params == null) {
      throw ArgumentError("Params cannot be null");
    }
    await _authLocalRepository.saveToken(params);
  }
}
