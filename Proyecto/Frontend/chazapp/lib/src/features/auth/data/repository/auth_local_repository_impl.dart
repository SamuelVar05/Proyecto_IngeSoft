import 'package:chazapp/src/features/auth/data/data_sources/local/auth_local_storage_service.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_local_repository.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepository {
  final AuthLocalStorageService _authLocalStorageService;

  AuthLocalRepositoryImpl(this._authLocalStorageService);

  @override
  Future<void> deleteToken() async {
    await _authLocalStorageService.deleteToken();
  }

  @override
  Future<String?> getToken() async {
    return await _authLocalStorageService.getToken();
  }

  @override
  Future<void> saveToken(String token) async {
    await _authLocalStorageService.saveToken(token);
  }
}
