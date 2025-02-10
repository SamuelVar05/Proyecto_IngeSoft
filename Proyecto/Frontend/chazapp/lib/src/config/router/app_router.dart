import 'package:go_router/go_router.dart';
import 'package:chazapp/src/auth/presentation/screens/login_screen.dart';
import 'package:chazapp/src/auth/presentation/screens/signup_screen.dart';
import 'package:chazapp/src/auth/presentation/screens/home_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
