import 'package:chazapp/src/features/auth/data/data_sources/remote/login_api_service.dart';
import 'package:chazapp/src/features/auth/data/data_sources/remote/register_api_service.dart';
import 'package:chazapp/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:chazapp/src/features/auth/domain/repository/auth_repository.dart';
import 'package:chazapp/src/features/auth/domain/usecases/login.dart';
import 'package:chazapp/src/features/auth/domain/usecases/register.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<LoginApiService>(LoginApiService(sl()));
  sl.registerSingleton<RegisterApiService>(RegisterApiService(sl()));

  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl(), sl()),
  );

  // UseCases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(sl()));

  // Blocs
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl()),
  );
  sl.registerFactory<RegisterBloc>(
    () => RegisterBloc(sl()),
  );
}
