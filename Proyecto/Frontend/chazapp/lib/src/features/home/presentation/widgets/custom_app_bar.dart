import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppBarType { home, back, profile }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarType type;
  final String? imageUrl;
  final VoidCallback? onExitPressed;

  const CustomAppBar({
    super.key,
    required this.type,
    this.imageUrl,
    this.onExitPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: UNChazaTheme.orange,
      leading: _buildLeading(context),
      title: Image.asset(
        'assets/unchaza_logo.png',
        height: 50,
      ),
      centerTitle: true,
      actions: _buildActions(context),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    switch (type) {
      case AppBarType.home:
        return IconButton(
          icon: const Icon(Icons.favorite, color: UNChazaTheme.mainGrey),
          onPressed: () => context.go("/favorites"),
        );
      case AppBarType.back:
        return IconButton(
          icon: const Icon(Icons.arrow_back, color: UNChazaTheme.mainGrey),
          onPressed: () => context.pop(),
        );
      case AppBarType.profile:
        return IconButton(
          icon: const Icon(Icons.home, color: UNChazaTheme.mainGrey),
          onPressed: () => context.go("/home"),
        );
    }
  }

  List<Widget>? _buildActions(BuildContext context) {
    switch (type) {
      case AppBarType.home:
        return [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => context.go("/profile"),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: UNChazaTheme.mainGrey, width: 2),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(imageUrl ?? ''),
                ),
              ),
            ),
          ),
        ];
      case AppBarType.back:
        return null;
      case AppBarType.profile:
        return [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: onExitPressed ?? () {},
          ),
        ];
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
