import 'package:flutter/material.dart';

class FavoriteCharacterButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onPressed;
  final Color? activeColor;
  final Color? inactiveColor;

  const FavoriteCharacterButton({
    super.key,
    required this.isFavorite,
    this.onPressed,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(final BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      tooltip: isFavorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
      onPressed: onPressed,
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? (activeColor ?? Colors.red) : inactiveColor,
      ),
    );
  }
}
