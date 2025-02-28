import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/profile/domain/enitites/profile_entity.dart';

abstract class ProfileRepository {
  Future<DataState<ProfileEntity>> getProfile(String token);
}
