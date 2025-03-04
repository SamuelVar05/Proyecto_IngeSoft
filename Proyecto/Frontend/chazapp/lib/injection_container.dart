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
import 'package:chazapp/src/features/home/data/data_sources/remote/productos_api_service.dart';
import 'package:chazapp/src/features/home/data/repository/productos_repository_impl.dart';
import 'package:chazapp/src/features/home/domain/repository/productos_repository.dart';
import 'package:chazapp/src/features/home/domain/usecases/get_productos.dart';
import 'package:chazapp/src/features/home/presentation/bloc/productos/productos_bloc.dart';
import 'package:chazapp/src/features/profile/data/data_sources/remote/profile_api_service.dart';
import 'package:chazapp/src/features/profile/data/repository/profile_repository_impl.dart';
import 'package:chazapp/src/features/profile/domain/repository/profile_repository.dart';
import 'package:chazapp/src/features/profile/domain/usecases/get_chazas.dart';
import 'package:chazapp/src/features/profile/domain/usecases/get_profile.dart';
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
  sl.registerSingleton<ProfileApiService>(ProfileApiService(sl()));
  sl.registerSingleton<ProductosApiService>(ProductosApiService(sl()));

  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerSingleton<AuthLocalRepository>(AuthLocalRepositoryImpl(sl()));

  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(sl()));

  sl.registerSingleton<ProductosRepository>(ProductosRepositoryImpl(sl()));

  // UseCases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(sl()));
  sl.registerSingleton<GetTokenUseCase>(GetTokenUseCase(sl()));
  sl.registerSingleton<DeleteTokenUseCase>(DeleteTokenUseCase(sl()));
  sl.registerSingleton<SaveTokenUseCase>(SaveTokenUseCase(sl()));
  sl.registerSingleton<GetProfileUseCase>(GetProfileUseCase(sl()));
  sl.registerSingleton<GetChazasUseCase>(GetChazasUseCase(sl()));
  sl.registerSingleton<GetProductosUseCase>(GetProductosUseCase(sl()));

  // Blocs
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl(), sl(), sl(), sl()),
  );
  sl.registerFactory<RegisterBloc>(
    () => RegisterBloc(sl()),
  );

  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(sl(), sl()),
  );

  sl.registerFactory<ProductosBloc>(() => ProductosBloc(sl()));
}
