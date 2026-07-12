import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/features/character/presentation/bloc/character_bloc.dart';
import 'package:morty_app/features/character/presentation/bloc/character_state.dart';

class CharacterSearchHeader extends StatelessWidget {
  final TextEditingController nameController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onOpenFilters;
  final VoidCallback onClearFilters;

  const CharacterSearchHeader({
    super.key,
    required this.nameController,
    required this.onSearchChanged,
    required this.onOpenFilters,
    required this.onClearFilters,
  });

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Buscar personaje...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: onSearchChanged,
                ),
              ),
              const SizedBox(width: 12),
              CharacterFilterButton(onOpenFilters: onOpenFilters),
            ],
          ),
          const SizedBox(height: 8),
          CharacterFilterSummary(onClearFilters: onClearFilters),
        ],
      ),
    );
  }
}

class CharacterFilterButton extends StatelessWidget {
  final VoidCallback onOpenFilters;

  const CharacterFilterButton({required this.onOpenFilters, super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<CharacterBloc, CharacterState, CharacterState>(
      selector: (final state) => state,
      builder: (final context, final state) {
        final hasAdvancedFilters = _hasAdvancedFilters(state);

        return Badge(
          isLabelVisible: hasAdvancedFilters,
          label: Text('${_advancedFilterCount(state)}'),
          child: SizedBox(
            height: 56,
            child: OutlinedButton(
              onPressed: onOpenFilters,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Icon(Icons.tune),
            ),
          ),
        );
      },
    );
  }
}

class CharacterFilterSummary extends StatelessWidget {
  final VoidCallback onClearFilters;

  const CharacterFilterSummary({required this.onClearFilters, super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<CharacterBloc, CharacterState, CharacterState>(
      selector: (final state) => state,
      builder: (final context, final state) {
        final activeFilters = _buildActiveFilterLabels(state);
        if (activeFilters.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Filtros activos',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: onClearFilters,
                    child: const Text('Limpiar'),
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: activeFilters
                    .map(
                      (final filter) => Chip(
                        visualDensity: VisualDensity.compact,
                        label: Text(filter),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

bool _hasAdvancedFilters(final CharacterState state) {
  return state.currentStatusFilter != null ||
      state.currentGenderFilter != null ||
      state.currentSpeciesFilter.isNotEmpty ||
      state.currentTypeFilter.isNotEmpty;
}

int _advancedFilterCount(final CharacterState state) {
  var count = 0;
  if (state.currentStatusFilter != null) {
    count++;
  }
  if (state.currentGenderFilter != null) {
    count++;
  }
  if (state.currentSpeciesFilter.isNotEmpty) {
    count++;
  }
  if (state.currentTypeFilter.isNotEmpty) {
    count++;
  }
  return count;
}

List<String> _buildActiveFilterLabels(final CharacterState state) {
  final filters = <String>[];

  if (state.currentStatusFilter != null) {
    filters.add('Estado: ${state.currentStatusFilter!.displayName}');
  }
  if (state.currentGenderFilter != null) {
    filters.add('Genero: ${state.currentGenderFilter!.displayName}');
  }
  if (state.currentSpeciesFilter.isNotEmpty) {
    filters.add('Especie: ${state.currentSpeciesFilter}');
  }
  if (state.currentTypeFilter.isNotEmpty) {
    filters.add('Tipo: ${state.currentTypeFilter}');
  }

  return filters;
}
