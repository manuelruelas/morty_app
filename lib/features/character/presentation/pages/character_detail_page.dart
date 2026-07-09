import 'package:flutter/material.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 💡 ANIMACIÓN HERO: El tag debe coincidir exactamente con el de la tarjeta
            Hero(
              tag: 'character-image-${character.id}',
              child: Image.network(
                character.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (final context, final error, final stackTrace) =>
                    const SizedBox(
                      height: 300,
                      child: Center(child: Icon(Icons.broken_image, size: 64)),
                    ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Información en Tarjetas o ListTiles limpios
                  _buildInfoTile(
                    context,
                    icon: Icons.lens,
                    title: 'Estado',
                    value: character.status.displayName,
                    iconColor: character.status == CharacterStatus.alive
                        ? Colors.green
                        : character.status == CharacterStatus.dead
                        ? Colors.red
                        : Colors.grey,
                  ),
                  _buildInfoTile(
                    context,
                    icon: Icons.face,
                    title: 'Especie',
                    value: character.species,
                  ),
                  _buildInfoTile(
                    context,
                    icon: Icons.public,
                    title: 'Origen',
                    value: character.locationName,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoTile(
  final BuildContext context, {
  required final IconData icon,
  required final String title,
  required final String value,
  final Color? iconColor,
}) {
  final theme = Theme.of(context);
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    elevation: 0,
    color: theme.colorScheme.surfaceContainerLow,
    child: ListTile(
      leading: Icon(icon, color: iconColor ?? theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.bodySmall),
      subtitle: Text(
        value,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
