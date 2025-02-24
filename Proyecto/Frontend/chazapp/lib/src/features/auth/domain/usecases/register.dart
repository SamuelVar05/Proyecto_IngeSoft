import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/auth/domain/entities/register_entity.dart';
import 'package:chazapp/src/features/auth/domain/entities/register_request_entitity.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase
    implements UseCase<DataState<RegisterEntity>, RegisterRequestEntity> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<DataState<RegisterEntity>> call({RegisterRequestEntity? params}) {
    if (params == null) {
      throw ArgumentError("Params cannot be null");
    }
    return _authRepository.register(params.email, params.password);
  }
}
