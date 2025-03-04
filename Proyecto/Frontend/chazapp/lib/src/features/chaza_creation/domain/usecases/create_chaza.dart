import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/core/usecase/usecase.dart';
import 'package:chazapp/src/features/chaza_creation/domain/entity/chaza_request_entity.dart';
import 'package:chazapp/src/features/chaza_creation/domain/repository/chaza_repository.dart';

class CreateChazaUseCase
    implements UseCase<DataState<void>, Map<String, dynamic>> {
  final ChazaRepository _chazaRepository;

  CreateChazaUseCase(this._chazaRepository);

  @override
  Future<DataState<void>> call({required Map<String, dynamic> params}) {
    final String token = params['token'];
    final ChazaRequestEntity chazaRequestEntity = params['chazaRequestEntity'];

    return _chazaRepository.createChaza(
      idUsuario: chazaRequestEntity.id_usuario,
      nombre: chazaRequestEntity.nombre,
      descripcion: chazaRequestEntity.descripcion,
      ubicacion: chazaRequestEntity.ubicacion,
      idPhoto: chazaRequestEntity.foto_id,
      token: token,
    );
  }
}
