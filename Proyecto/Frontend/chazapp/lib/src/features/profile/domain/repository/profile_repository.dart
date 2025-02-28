import 'package:chazapp/src/features/profile/domain/enitites/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
}