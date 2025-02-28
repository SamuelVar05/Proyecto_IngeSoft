import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/profile/domain/enitites/profile_entity.dart';
import 'package:chazapp/src/features/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase implements UseCase<DataState<ProfileEntity>, String> {

  final ProfileRepository _profileRepository;

  GetProfileUseCase(this._profileRepository);

  @override
  Future<DataState<ProfileEntity>> call({String? params}) {
    if (params == null) {
      throw ArgumentError("Params cannot be null");
    }

    return _profileRepository.getProfile(params);
  }  
}