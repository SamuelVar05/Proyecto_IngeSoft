import 'package:chazapp/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:chazapp/src/features/auth/presentation/screens/login_screen.dart';
import 'package:chazapp/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:chazapp/src/features/auth/presentation/screens/home_screen.dart';

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
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
      // TODO: Change to the logic with data from the login
      // builder: (context, state) =>
      //     const ProfileSuccessScreen(email: "samuevarga@gmail.com"),
    ),
  ],
);
