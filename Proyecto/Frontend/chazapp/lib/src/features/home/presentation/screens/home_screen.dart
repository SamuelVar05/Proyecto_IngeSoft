import 'package:chazapp/src/features/home/presentation/bloc/productos/productos_bloc.dart';
import 'package:chazapp/src/features/home/presentation/bloc/productos/productos_event.dart';
import 'package:chazapp/src/features/home/presentation/bloc/productos/productos_state.dart';
import 'package:go_router/go_router.dart';
import 'package:chazapp/src/features/home/presentation/widgets/product_card.dart';
import 'package:chazapp/src/features/home/presentation/widgets/search_bar_widget.dart';
import 'package:chazapp/src/features/home/presentation/widgets/chaza_card.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chazapp/src/features/auth/presentation/bloc/login/login_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearchingProducts =
      true; // Estado global para cambiar entre productos y chazas

  // Lista de productos simulada
  final List<Map<String, dynamic>> products = List.generate(15, (index) {
    return {
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8gPuvWQDT1siypHfSPCGlJj1Ba_HwjmM_aw&s',
      'productName': 'Hamburguesa Clásica',
      'chazaName': 'Hamburguesitas',
      'category': 'Comida rápida',
      'price': 25000,
      'isFavorite': false,
      'description':
          'Jugosa carne de res a la parrilla, pan suave y dorado, lechuga fresca, tomate, cebolla, queso derretido y nuestra deliciosa salsa especial. ¡Sencilla, pero llena de sabor!'
    };
  });

  // Lista de chazas simulada
  final List<Map<String, dynamic>> chazas = List.generate(10, (index) {
    return {
      'isFavorite': false,
      'isOwner': true,
      'schedule': 'L-V 9:00am-5:00pm',
      'payment': 'Nequi,Daviplata',
      'imageUrl':
          'https://i.pinimg.com/236x/15/ee/bf/15eebf77c19a47dd2c413f8b844bd8e9.jpg',
      'chazaName': 'Cafesito UNAL',
      'location': 'CyT',
      'description':
          'En nuestra chaza Cafesito para todos encontrarás bebidas calientes y snacks con un toque casero y sabores irresistibles. Es el lugar perfecto para disfrutar de una comida deliciosa y rápida, como si la preparara tu barista de confianza. ¡Siempre con el mejor sabor y a la orden!',
      'onFavoritePressed': () {},
    };
  });

  // Función para alternar favoritos
  void toggleFavorite(int index, bool isProduct) {
    setState(() {
      if (isProduct) {
        products[index]['isFavorite'] = !products[index]['isFavorite'];
      } else {
        chazas[index]['isFavorite'] = !chazas[index]['isFavorite'];
      }
    });
  }

  // Función para cambiar entre productos y chazas
  void updateSearchMode(bool isProductSearch) {
    setState(() {
      isSearchingProducts = isProductSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UNChazaTheme.white,
      appBar: const CustomAppBar(
        type: AppBarType.home,
        imageUrl:
            'https://images.crunchbase.com/image/upload/c_thumb,h_256,w_256,f_auto,g_face,z_0.7,q_auto:eco,dpr_1/xh3bkyq1g1yx5rasenzt',
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is! LoginSuccess) {
            context.go('/');
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is! LoginSuccess) {
            // context.go("/");
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final token = (state).userEntity.token;

          context.read<ProductosBloc>().add(LoadProductsEvent(token: token));
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false, // No se queda fijo
                floating: true,
                snap: true, // Se oculta al hacer scroll
                backgroundColor: UNChazaTheme.orange,
                elevation: 0,
                //shadowColor: Colors.transparent,
                //forceMaterialTransparency: true,

                expandedHeight: 230,
                flexibleSpace: FlexibleSpaceBar(
                  background: SearchBarWidget(
                    userName: "Juliana",
                    onSearch: (query) => print("Buscar: $query"),
                    onScan: () => print("Escanear producto"),
                    onFilterProducts: () => print("Filtrar productos"),
                    onFilterChazas: () => print("Filtrar chazas"),
                    onToggleSearch:
                        updateSearchMode, // Permite cambiar la vista
                  ),
                ),
              ),
              if (isSearchingProducts)
                BlocBuilder<ProductosBloc, ProductosState>(
                  builder: (context, state) {
                    if (state is ProductosLoading) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: UNChazaTheme.orange,
                          ),
                        ),
                      );
                    } else if (state is ProductosLoaded) {
                      if (state.productos.isEmpty) {
                        return const SliverFillRemaining(
                          child: Center(
                            child: Text('No hay productos'),
                          ),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = state.productos[index];
                            return ProductCard(
                              imageUrl:
                                  "https://images.crunchbase.com/image/upload/c_thumb,h_256,w_256,f_auto,g_face,z_0.7,q_auto:eco,dpr_1/xh3bkyq1g1yx5rasenzt",
                              productName: product.name,
                              chazaName: "Chaza",
                              category: "Comida",
                              price: product.price as int,
                              isFavorite: false,
                              description: product.description,
                              onFavoritePressed: () =>
                                  toggleFavorite(index, true),
                            );
                          },
                          childCount: state.productos.length,
                        ),
                      );
                    } else if (state is ProductosError) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Text(
                              'Error cargando productos ${state.exception}'),
                        ),
                      );
                    } else {
                      return const SliverFillRemaining(
                        child: Center(
                          child: Text('Error desconocido'),
                        ),
                      );
                    }
                  },
                )
              else
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  final chaza = chazas[index];
                  return ChazaCard(
                    isFavorite: chaza['isFavorite'],
                    isOwner: chaza['isOwner'],
                    schedule: chaza['schedule'],
                    payment: chaza['payment'],
                    imageUrl: chaza['imageUrl'],
                    chazaName: chaza['chazaName'],
                    location: chaza['location'],
                    description: chaza['description'],
                    onFavoritePressed: () => toggleFavorite(index, false),
                  );
                }, childCount: chazas.length)),
            ],
          );
        }),
      ),
    );
  }
}
