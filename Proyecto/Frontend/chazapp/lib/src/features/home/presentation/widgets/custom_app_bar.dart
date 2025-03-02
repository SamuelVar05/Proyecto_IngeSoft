import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showFavorites;
  final VoidCallback? onExitPressed;
  final String imageUrl;

  const CustomAppBar({
    super.key,
    this.showFavorites = true,
    this.onExitPressed,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: UNChazaTheme.orange,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          icon: Icon(
            showFavorites ? Icons.favorite : Icons.home,
            color: UNChazaTheme.mainGrey,
          ),
          onPressed: () {
            context.go(showFavorites ? "/favorites" : "/home");
          },
        ),
      ),
      title: Image.asset(
        'assets/unchaza_logo.png',
        height: 50,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: showFavorites
              ? GestureDetector(
                  onTap: () {
                    context.go("/profile");
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: UNChazaTheme.mainGrey, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                        imageUrl,
                      ),
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.exit_to_app, color: Colors.white),
                  onPressed: onExitPressed ?? () {},
                ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
