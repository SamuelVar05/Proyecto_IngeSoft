import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/chaza_creation/domain/entity/chaza_request_entity.dart';

abstract class ChazaRepository {
  Future<DataState<void>> createChaza(ChazaRequestEntity chazaRequest);
}
