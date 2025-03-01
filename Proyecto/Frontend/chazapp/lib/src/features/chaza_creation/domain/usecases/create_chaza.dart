import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/chaza_creation/domain/entity/chaza_request_entity.dart';
import 'package:chazapp/src/features/chaza_creation/domain/repository/chaza_repository.dart';

class CreateChaza implements UseCase<DataState<void>, ChazaRequestEntity> {

  final ChazaRepository _chazaRepository;

  CreateChaza(this._chazaRepository);

  @override
  Future<DataState<void>> call({required ChazaRequestEntity params}) {
    return _chazaRepository.createChaza(params);
  }

}