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
    final token = context.select<LoginBloc, String>((bloc) {
      final state = bloc.state;
      if (state is LoginSuccess) {
        return state.userEntity.token;
      }
      throw Exception('No se pudo obtener el token');
    });

    return Scaffold(
      backgroundColor: UNChazaTheme.white,
      appBar: const CustomAppBar(
        type: AppBarType.home,
        imageUrl:
            'https://images.crunchbase.com/image/upload/c_thumb,h_256,w_256,f_auto,g_face,z_0.7,q_auto:eco,dpr_1/xh3bkyq1g1yx5rasenzt',
      ),
      body: CustomScrollView(
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
                onToggleSearch: updateSearchMode, // Permite cambiar la vista
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (isSearchingProducts) {
                  final product = products[index];
                  return ProductCard(
                    imageUrl: product['imageUrl'],
                    productName: product['productName'],
                    chazaName: product['chazaName'],
                    category: product['category'],
                    price: product['price'],
                    isFavorite: product['isFavorite'],
                    description: product['description'],
                    onFavoritePressed: () => toggleFavorite(index, true),
                  );
                } else {
                  final chaza = chazas[index];
                  return ChazaCard(
                    isFavorite: chaza['isFavorite'],
                    schedule: chaza['schedule'],
                    payment: chaza['payment'],
                    imageUrl: chaza['imageUrl'],
                    chazaName: chaza['chazaName'],
                    location: chaza['location'],
                    description: chaza['description'],
                    onFavoritePressed: () => toggleFavorite(index, false),
                  );
                }
              },
              childCount: isSearchingProducts ? products.length : chazas.length,
            ),
          ),
        ],
      ),
    );
  }
}
