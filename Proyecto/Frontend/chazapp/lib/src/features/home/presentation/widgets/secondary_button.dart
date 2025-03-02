import 'package:chazapp/src/config/themes/unchaza_theme.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final IconData? icon;
  final VoidCallback onPressed;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Se ajusta al tamaño del contenido
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: textColor),
                const SizedBox(width: 6),
              ],
              Text(
                text,
                style: UNChazaTheme.textTheme.titleLarge
                    ?.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
