import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String chazaName;
  final String category;
  final int price;
  late bool isFavorite;
  final VoidCallback onFavoritePressed;

  ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.chazaName,
    required this.category,
    required this.price,
    required this.isFavorite,
    required this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: UNChazaTheme.mainGrey,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12), // Espacio entre la imagen y el texto

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: UNChazaTheme.textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 4),

                  // Chaza
                  Row(
                    children: [
                      const Icon(Icons.place,
                          size: 16, color: UNChazaTheme.orange),
                      const SizedBox(width: 4),
                      Text(
                        'Chaza "$chazaName"',
                        style: UNChazaTheme.textTheme.bodyLarge,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Categoría
                  Row(
                    children: [
                      const Icon(Icons.restaurant,
                          size: 16, color: UNChazaTheme.orange),
                      const SizedBox(width: 4),
                      Text(category, style: UNChazaTheme.textTheme.bodyLarge),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Precio
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: UNChazaTheme.yellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '\$${price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Botón de favorito
            SizedBox(
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color:
                          isFavorite ? UNChazaTheme.red : UNChazaTheme.darkGrey,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
