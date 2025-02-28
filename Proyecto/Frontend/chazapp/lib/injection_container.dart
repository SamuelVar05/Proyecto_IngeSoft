import 'package:chazapp/src/features/auth/data/data_sources/local/auth_local_storage_service.dart';
import 'package:chazapp/src/features/auth/data/data_sources/remote/login_api_service.dart';
import 'package:chazapp/src/features/auth/data/data_sources/remote/register_api_service.dart';
import 'package:chazapp/src/features/auth/data/repository/auth_local_repository_impl.dart';
import 'package:chazapp/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_repository.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_local_repository.dart';
import 'package:chazapp/src/features/auth/domain/usecases/delete_token.dart';
import 'package:chazapp/src/features/auth/domain/usecases/get_token.dart';
import 'package:chazapp/src/features/auth/domain/usecases/login.dart';
import 'package:chazapp/src/features/auth/domain/usecases/register.dart';
import 'package:chazapp/src/features/auth/domain/usecases/save_token.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<LoginApiService>(LoginApiService(sl()));
  sl.registerSingleton<RegisterApiService>(RegisterApiService(sl()));
  sl.registerSingleton<AuthLocalStorageService>(AuthLocalStorageService());

  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerSingleton<AuthLocalRepository>(AuthLocalRepositoryImpl(sl()));

  // UseCases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(sl()));
  sl.registerSingleton<GetTokenUseCase>(GetTokenUseCase(sl()));
  sl.registerSingleton<DeleteTokenUseCase>(DeleteTokenUseCase(sl()));
  sl.registerSingleton<SaveTokenUseCase>(SaveTokenUseCase(sl()));

  // Blocs
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl(), sl(), sl(), sl()),
  );
  sl.registerFactory<RegisterBloc>(
    () => RegisterBloc(sl()),
  );

  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(),
  );
}
