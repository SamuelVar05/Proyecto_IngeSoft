import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:chazapp/src/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String chazaName;
  final String category;
  final String description;
  final int price;

  const ProductDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.chazaName,
    required this.category,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(type: AppBarType.back),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(productName,
                      style: UNChazaTheme.textTheme.displayLarge
                          ?.copyWith(color: UNChazaTheme.orange)),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      imageUrl,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: UNChazaTheme.yellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '\$${price.toStringAsFixed(0)}',
                      style: UNChazaTheme.textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(description, style: UNChazaTheme.textTheme.bodyLarge),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: UNChazaTheme.orange.withAlpha(40),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              child: Text('Ubicación',
                  style: UNChazaTheme.textTheme.headlineMedium?.copyWith(
                    color: UNChazaTheme.orange,
                  )),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.place, size: 22, color: UNChazaTheme.orange),
                const SizedBox(width: 4),
                Text('Chaza "$chazaName"',
                    style: UNChazaTheme.textTheme.headlineSmall),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: UNChazaTheme.orange.withAlpha(40),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              child: Text('Categoria',
                  style: UNChazaTheme.textTheme.headlineMedium?.copyWith(
                    color: UNChazaTheme.orange,
                  )),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.restaurant,
                    size: 18, color: UNChazaTheme.orange),
                const SizedBox(width: 4),
                Text(category, style: UNChazaTheme.textTheme.headlineSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
