import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/auth/domain/entities/login_request_entity.dart';
import 'package:chazapp/src/features/auth/domain/entities/user_entity.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase
    implements UseCase<DataState<LoginEntity>, LoginRequestEntity> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<DataState<LoginEntity>> call({LoginRequestEntity? params}) {
    if (params == null) {
      throw ArgumentError("Params cannot be null");
    }
    return _authRepository.login(params.email, params.password);
  }
}
