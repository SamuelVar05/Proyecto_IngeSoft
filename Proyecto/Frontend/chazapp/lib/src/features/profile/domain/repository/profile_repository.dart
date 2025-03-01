import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/profile/domain/enitites/chaza_entity.dart';
import 'package:chazapp/src/features/profile/domain/enitites/profile_entity.dart';

abstract class ProfileRepository {
  Future<DataState<ProfileEntity>> getProfile(String token);
  Future<DataState<List<ChazaEntity>>> getChazas(String token, String userId);
}
