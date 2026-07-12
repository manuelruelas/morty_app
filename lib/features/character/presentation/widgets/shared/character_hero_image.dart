import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterHeroImage extends StatelessWidget {
  final int characterId;
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;

  const CharacterHeroImage({
    super.key,
    required this.characterId,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
  });

  @override
  Widget build(final BuildContext context) {
    final placeholderColor = Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest;

    return Hero(
      tag: 'character-image-$characterId',
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (final context, final url) => Container(
          width: width,
          height: height,
          color: placeholderColor,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (final context, final url, final error) =>
            errorWidget ??
            SizedBox(
              width: width,
              height: height,
              child: const Icon(Icons.broken_image),
            ),
      ),
    );
  }
}
