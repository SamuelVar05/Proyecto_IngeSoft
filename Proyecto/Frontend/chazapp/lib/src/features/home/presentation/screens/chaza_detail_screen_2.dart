import 'package:chazapp/src/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:chazapp/src/features/home/presentation/widgets/custom_button.dart';
import 'package:chazapp/src/features/home/presentation/widgets/product_card.dart';
import 'package:chazapp/src/features/profile/domain/enitites/chaza_entity.dart';
import 'package:flutter/material.dart';
import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:go_router/go_router.dart';

class ChazaDetailScreen2 extends StatelessWidget {
  final String imageUrl;
  final String schedule;
  final String payment;
  final bool isOwner;
  final ChazaEntity chaza;

  ChazaDetailScreen2(
      {super.key,
      required this.imageUrl,
      required this.schedule,
      required this.payment,
      required this.isOwner,
      required this.chaza});

  late String chazaName = chaza.nombre;
  late String location =
      chaza.ubicacion == "" ? 'Ubicación no especificada' : chaza.ubicacion!;
  late String description = chaza.descripcion;

  // Simulación de productos de la chaza
  List<Map<String, dynamic>> generateProducts(String chazaName) {
    return List.generate(5, (index) {
      return {
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCE4TTuebY9YT632lGpqCziDJqwI4dD4DW2w&s',
        'productName': 'Cappuchino',
        'chazaName': chazaName,
        'category': 'Bebidas',
        'price': 7000,
        'isFavorite': false,
        'description':
            'Delicioso cafe con leche entera, espuma y azucar ¡Sencillo, pero lleno de sabor!'
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UNChazaTheme.white,
      appBar: const CustomAppBar(type: AppBarType.back),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(chazaName,
                  style: UNChazaTheme.textTheme.displayLarge
                      ?.copyWith(color: UNChazaTheme.orange)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.place,
                                size: 22, color: UNChazaTheme.deepGrey),
                            const SizedBox(width: 4),
                            Container(
                              decoration: BoxDecoration(
                                  color: UNChazaTheme.darkGrey.withAlpha(20),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                              child: Text(location,
                                  style: UNChazaTheme.textTheme.headlineSmall),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.access_time_filled_sharp,
                                size: 22, color: UNChazaTheme.deepGrey),
                            const SizedBox(width: 4),
                            Container(
                              decoration: BoxDecoration(
                                  color: UNChazaTheme.darkGrey.withAlpha(20),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                              child: Text(schedule,
                                  style: UNChazaTheme.textTheme.headlineSmall),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.payment,
                                size: 22, color: UNChazaTheme.deepGrey),
                            const SizedBox(width: 4),
                            Container(
                              decoration: BoxDecoration(
                                  color: UNChazaTheme.darkGrey.withAlpha(20),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                              child: Text(payment,
                                  style: UNChazaTheme.textTheme.headlineSmall),
                            ),
                          ],
                        ),
                      ]),
                  const SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      imageUrl,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(description,
                      style: UNChazaTheme.textTheme.bodyLarge,
                      textAlign: TextAlign.justify),
                  const SizedBox(height: 10),
                  isOwner
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomButton(
                                  text: "Editar",
                                  buttonColor: UNChazaTheme.blue,
                                  textColor: UNChazaTheme.white,
                                  icon: Icons.edit,
                                  onPressed: () =>
                                      context.go('/edit-chaza', extra: {
                                    "name": chazaName,
                                    "description": description,
                                    "location": location,
                                    "schedule": schedule,
                                    "imageUrl": imageUrl,
                                    "payments": payment.split(", "),
                                  }),
                                ),
                                const SizedBox(width: 5),
                                CustomButton(
                                  text: "Eliminar",
                                  buttonColor: UNChazaTheme.red,
                                  textColor: UNChazaTheme.white,
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: UNChazaTheme.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        side: BorderSide(
                                            color: UNChazaTheme.orange,
                                            width: 2.0),
                                      ),
                                      title: const Text('Eliminar chaza'),
                                      titleTextStyle:
                                          UNChazaTheme.textTheme.displayMedium,
                                      content: const Text(
                                          '¿Estás seguro de que deseas eliminar esta chaza?'),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        CustomButton(
                                          text: "Cancelar",
                                          buttonColor: UNChazaTheme.deepGrey,
                                          textColor: UNChazaTheme.white,
                                          onPressed: () => context.pop(),
                                        ),
                                        CustomButton(
                                          text: "Eliminar",
                                          buttonColor: UNChazaTheme.red,
                                          textColor: UNChazaTheme.white,
                                          onPressed: () {
                                            context.pop();
                                            context.pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      : Container(),
                  Text("Productos",
                      style: UNChazaTheme.textTheme.displayMedium,
                      textAlign: TextAlign.start),
                  const Divider(
                    height: 4,
                    color: UNChazaTheme.lightGrey,
                    thickness: 2,
                  ),
                  if (isOwner)
                    CustomButton(
                      text: "Agregar Producto",
                      buttonColor: UNChazaTheme.orange,
                      textColor: UNChazaTheme.white,
                      onPressed: () => {},
                      icon: Icons.add_circle_outline_rounded,
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: generateProducts(chazaName).length,
                    itemBuilder: (context, index) {
                      final product = generateProducts(chazaName)[index];
                      return ProductCard(
                        imageUrl: product['imageUrl'],
                        productName: product['productName'],
                        chazaName: product['chazaName'],
                        category: product['category'],
                        price: product['price'],
                        isFavorite: product['isFavorite'],
                        description: product['description'],
                        onFavoritePressed: () => (),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
