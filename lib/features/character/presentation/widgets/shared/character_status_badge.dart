import 'package:flutter/material.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';

Color characterStatusColor(final CharacterStatus status) {
  switch (status) {
    case CharacterStatus.alive:
      return Colors.green;
    case CharacterStatus.dead:
      return Colors.red;
    case CharacterStatus.unknown:
      return Colors.grey;
  }
}

class CharacterStatusText extends StatelessWidget {
  final CharacterStatus status;
  final String? trailingText;

  const CharacterStatusText({
    super.key,
    required this.status,
    this.trailingText,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = characterStatusColor(status);
    final label = trailingText == null || trailingText!.isEmpty
        ? status.displayName
        : '${status.displayName} - $trailingText';

    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class CharacterStatusBadge extends StatelessWidget {
  final CharacterStatus status;

  const CharacterStatusBadge({super.key, required this.status});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = characterStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            status.displayName.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
