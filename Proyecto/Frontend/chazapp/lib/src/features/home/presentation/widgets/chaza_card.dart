import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:chazapp/src/features/profile/domain/enitites/chaza_entity.dart';
import 'package:flutter/material.dart';

class ChazaCard extends StatelessWidget {
  final ChazaEntity chaza;
  final bool isFavorite;
  final bool isOwner;
  final String imageUrl;
  final VoidCallback onFavoritePressed;
  final VoidCallback onTap;

  const ChazaCard({
    super.key,
    required this.chaza,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.isOwner,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                child: Image.asset(
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
                      chaza.nombre,
                      style: UNChazaTheme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    if (chaza.ubicacion != null) ...[
                      Row(
                        children: [
                          const Icon(Icons.place,
                              size: 16, color: UNChazaTheme.orange),
                          const SizedBox(width: 4),
                          Text(
                            chaza.ubicacion!,
                            style: UNChazaTheme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      chaza.descripcion,
                      style: UNChazaTheme.textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
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
