import 'package:chazapp/src/features/chaza_creation/presentation/screens/create_chaza_screen.dart';
import 'package:chazapp/src/features/chaza_creation/presentation/screens/edit_chaza_screen.dart';
import 'package:chazapp/src/features/favorites/presentation/favorites_screen.dart';
import 'package:chazapp/src/features/home/presentation/screens/chaza_detail_screen.dart';
import 'package:chazapp/src/features/home/presentation/screens/product_detail_screen.dart';
import 'package:chazapp/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:chazapp/src/features/auth/presentation/screens/login_screen.dart';
import 'package:chazapp/src/features/auth/presentation/screens/signup_screen.dart';
import 'package:chazapp/src/features/home/presentation/screens/home_screen.dart';

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
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/createchaza',
      name: 'createchaza',
      builder: (context, state) => CreateChazaScreen(),
    ),
    GoRoute(
      path: '/edit-chaza',
      builder: (context, state) {
        final Map<String, dynamic> chazaData =
            state.extra as Map<String, dynamic>;
        return EditChazaScreen(
          name: chazaData["name"],
          description: chazaData["description"],
          location: chazaData["location"],
          schedule: chazaData["schedule"],
          imageUrl: chazaData["imageUrl"],
          payments: List<String>.from(chazaData["payments"]),
        );
      },
    ),

    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
      // TODO: Change to the logic with data from the login
      // builder: (context, state) =>
      //     const ProfileSuccessScreen(email: "samuevarga@gmail.com"),
    ),
    //TODO: Cambiar estructura para acepatr un objeto Producto
    GoRoute(
      path: '/product-detail',
      builder: (context, state) {
        final productData = state.extra as Map<String, dynamic>;
        return ProductDetailScreen(
          imageUrl: productData['imageUrl'],
          productName: productData['productName'],
          chazaName: productData['chazaName'],
          category: productData['category'],
          price: productData['price'],
          description: productData['description'],
        );
      },
    ),
    GoRoute(
      path: '/chaza-detail',
      builder: (context, state) {
        final chazaData = state.extra as Map<String, dynamic>;
        return ChazaDetailScreen(
          isOwner: chazaData['isOwner'],
          imageUrl: chazaData['imageUrl'],
          chazaName: chazaData['chazaName'],
          schedule: chazaData['schedule'],
          location: chazaData['location'],
          payment: chazaData['payment'],
          description: chazaData['description'],
        );
      },
    ),
  ],
);
