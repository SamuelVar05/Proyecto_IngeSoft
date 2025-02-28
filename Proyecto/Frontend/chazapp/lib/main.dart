import 'package:chazapp/injection_container.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:chazapp/src/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/config/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LoginBloc>()),
        BlocProvider(create: (_) => sl<RegisterBloc>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
