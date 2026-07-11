import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const CharacterCard({
    super.key,
    required this.character,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    final Color statusColor;
    switch (character.status) {
      case CharacterStatus.alive:
        statusColor = Colors.green;
        break;
      case CharacterStatus.dead:
        statusColor = Colors.red;
        break;
      case CharacterStatus.unknown:
        statusColor = Colors.grey;
        break;
    }
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // Imagen del personaje con Hero animation para el detalle
            Hero(
              tag: 'character-image-${character.id}',
              child: CachedNetworkImage(
                imageUrl: character.imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                placeholder: (final context, final url) => Container(
                  width: 120,
                  height: 120,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (final context, final url, final error) =>
                    const SizedBox(
                      width: 120,
                      height: 120,
                      child: Icon(Icons.broken_image),
                    ),
              ),
            ),
            const SizedBox(width: 16),
            // Información textual
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          character.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          tooltip: isFavorite
                              ? 'Quitar de favoritos'
                              : 'Agregar a favoritos',
                          onPressed: onFavoriteTap,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${character.status.displayName} - ${character.species}',
                            style: theme.textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Última ubicación conocida:',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      character.locationName,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
