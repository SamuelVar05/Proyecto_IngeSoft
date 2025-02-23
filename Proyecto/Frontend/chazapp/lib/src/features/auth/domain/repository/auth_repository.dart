import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> login(String email, String password);
}
