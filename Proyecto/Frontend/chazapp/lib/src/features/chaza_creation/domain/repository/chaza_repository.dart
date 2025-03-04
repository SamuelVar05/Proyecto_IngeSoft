import 'package:chazapp/src/core/network/data_state.dart';

abstract class ChazaRepository {
  Future<DataState<void>> createChaza({
    required idUsuario,
    required nombre,
    required descripcion,
    ubicacion,
    idPhoto,
    required token,
  });
}
