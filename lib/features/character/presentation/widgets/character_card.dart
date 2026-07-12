import 'package:flutter/material.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/presentation/widgets/shared/character_hero_image.dart';
import 'package:morty_app/features/character/presentation/widgets/shared/character_status_badge.dart';
import 'package:morty_app/features/character/presentation/widgets/shared/favorite_character_button.dart';

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

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CharacterHeroImage(
              characterId: character.id,
              imageUrl: character.imageUrl,
              height: 120,
              width: 120,
              errorWidget: const SizedBox(
                width: 120,
                height: 120,
                child: Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(width: 16),
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
                        FavoriteCharacterButton(
                          isFavorite: isFavorite,
                          onPressed: onFavoriteTap,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CharacterStatusText(
                      status: character.status,
                      trailingText: character.species,
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
