import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChazaCard extends StatelessWidget {
  final String imageUrl;
  final String chazaName;
  final String schedule;
  final String location;
  final String payment;
  final String description;
  late bool isFavorite;
  final VoidCallback onFavoritePressed;

  ChazaCard({
    super.key,
    required this.imageUrl,
    required this.chazaName,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.schedule,
    required this.location,
    required this.payment,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/chaza-detail', extra: {
          'imageUrl': imageUrl,
          'chazaName': chazaName,
          'schedule': schedule,
          'location': location,
          'payment': payment,
          'description': description,
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: UNChazaTheme.mainGrey,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chazaName,
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
                          location,
                          style: UNChazaTheme.textTheme.bodyLarge,
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Horario
                    Row(
                      children: [
                        const Icon(Icons.access_time_filled_sharp,
                            size: 16, color: UNChazaTheme.orange),
                        const SizedBox(width: 4),
                        Text(schedule, style: UNChazaTheme.textTheme.bodyLarge),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Medio de pago
                    Row(
                      children: [
                        const Icon(Icons.payment,
                            size: 16, color: UNChazaTheme.orange),
                        const SizedBox(width: 4),
                        Text(payment, style: UNChazaTheme.textTheme.bodyLarge),
                      ],
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
                        isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite
                            ? UNChazaTheme.yellow
                            : UNChazaTheme.darkGrey,
                      ),
                      onPressed: onFavoritePressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
