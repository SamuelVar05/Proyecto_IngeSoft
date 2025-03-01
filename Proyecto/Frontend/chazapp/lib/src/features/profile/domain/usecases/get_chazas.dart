import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/profile/domain/enitites/chaza_entity.dart';
import 'package:chazapp/src/features/profile/domain/repository/profile_repository.dart';

class GetChazasParams {
  final String token;
  final String userId;

  GetChazasParams({required this.token, required this.userId});
}

class GetChazasUseCase
    implements UseCase<DataState<List<ChazaEntity>>, GetChazasParams> {
  final ProfileRepository _profileRepository;

  GetChazasUseCase(this._profileRepository);

  @override
  Future<DataState<List<ChazaEntity>>> call({GetChazasParams? params}) {
    if (params == null) {
      throw ArgumentError("Params cannot be null");
    }

    return _profileRepository.getChazas(params.token, params.userId);
  }
}
