import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/auth/domain/entities/register_entity.dart';
import 'package:chazapp/src/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<LoginEntity>> login(String email, String password);

  Future<DataState<RegisterEntity>> register(String email, String password);
}
