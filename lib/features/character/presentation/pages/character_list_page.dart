import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/theme/theme_cubit.dart';
import 'package:morty_app/features/character/domain/entities/character.dart';
import 'package:morty_app/features/character/presentation/pages/character_detail_page.dart';
import 'package:morty_app/features/character/presentation/widgets/character_card.dart';

import '../bloc/character_bloc.dart';
import '../bloc/character_event.dart';
import '../bloc/character_state.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) {
      return;
    }

    final bloc = context.read<CharacterBloc>();
    if (bloc.state.characters.isEmpty &&
        bloc.state.status == CharacterStatusState.initial) {
      bloc.add(const GetCharactersEvent());
    }
    _nameController.text = bloc.state.currentNameFilter;
    _speciesController.text = bloc.state.currentSpeciesFilter;
    _typeController.text = bloc.state.currentTypeFilter;
    if (bloc.state.favoriteCharacterIds.isEmpty &&
        bloc.state.favoriteCharacters.isEmpty) {
      bloc.add(const LoadFavoriteCharactersEvent());
    }
    _initialized = true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _speciesController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final bloc = context.read<CharacterBloc>();
    bloc.add(
      GetCharactersEvent(
        name: _nameController.text.trim(),
        status: bloc.state.currentStatusFilter,
        species: _speciesController.text.trim(),
        type: _typeController.text.trim(),
        gender: bloc.state.currentGenderFilter,
      ),
    );
  }

  void _clearAdvancedFilters() {
    _speciesController.clear();
    _typeController.clear();
    final bloc = context.read<CharacterBloc>();
    bloc.add(
      GetCharactersEvent(
        name: _nameController.text.trim(),
        status: null,
        species: null,
        type: null,
        gender: null,
      ),
    );
  }

  Future<void> _openAdvancedFilters() async {
    final bloc = context.read<CharacterBloc>();
    final speciesController = TextEditingController(
      text: bloc.state.currentSpeciesFilter,
    );
    final typeController = TextEditingController(
      text: bloc.state.currentTypeFilter,
    );
    CharacterStatus? selectedStatus = bloc.state.currentStatusFilter;
    CharacterGender? selectedGender = bloc.state.currentGenderFilter;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (final sheetContext) {
        return StatefulBuilder(
          builder: (final context, final setModalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Filtros avanzados',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              setModalState(() {
                                speciesController.clear();
                                typeController.clear();
                                selectedStatus = null;
                                selectedGender = null;
                              });
                            },
                            child: const Text('Limpiar'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: speciesController,
                        decoration: InputDecoration(
                          hintText: 'Filtrar por especie...',
                          prefixIcon: const Icon(Icons.pets),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: typeController,
                        decoration: InputDecoration(
                          hintText: 'Filtrar por tipo...',
                          prefixIcon: const Icon(Icons.category_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Estado',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('Todos'),
                            selected: selectedStatus == null,
                            onSelected: (final selected) {
                              setModalState(() {
                                selectedStatus = null;
                              });
                            },
                          ),
                          ...CharacterStatus.values.map((final status) {
                            return ChoiceChip(
                              label: Text(status.displayName),
                              selected: selectedStatus == status,
                              onSelected: (final selected) {
                                setModalState(() {
                                  selectedStatus = selected ? status : null;
                                });
                              },
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Género',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('Todos'),
                            selected: selectedGender == null,
                            onSelected: (final selected) {
                              setModalState(() {
                                selectedGender = null;
                              });
                            },
                          ),
                          ...CharacterGender.values.map((final gender) {
                            return ChoiceChip(
                              label: Text(gender.displayName),
                              selected: selectedGender == gender,
                              onSelected: (final selected) {
                                setModalState(() {
                                  selectedGender = selected ? gender : null;
                                });
                              },
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            _speciesController.text = speciesController.text;
                            _typeController.text = typeController.text;
                            bloc.add(
                              GetCharactersEvent(
                                name: _nameController.text.trim(),
                                status: selectedStatus,
                                species: speciesController.text.trim(),
                                type: typeController.text.trim(),
                                gender: selectedGender,
                              ),
                            );
                            Navigator.of(sheetContext).pop();
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Aplicar filtros'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    speciesController.dispose();
    typeController.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final bloc = context.read<CharacterBloc>();
      final state = bloc.state;
      if (state.status == CharacterStatusState.loadingMore ||
          state.status == CharacterStatusState.loading) {
        return;
      }
      bloc.add(LoadNextPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes R&M'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Buscar personaje...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (final value) => _applyFilters(),
                ),
                const SizedBox(height: 12),
                CharacterFilterBar(
                  onOpenFilters: _openAdvancedFilters,
                  onClearFilters: _clearAdvancedFilters,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (final context, final state) {
                switch (state.status) {
                  case CharacterStatusState.initial:
                  case CharacterStatusState.loading:
                    return const Center(child: CircularProgressIndicator());
                  case CharacterStatusState.empty:
                    return const Center(
                      child: Text('No se encontraron personajes.'),
                    );
                  case CharacterStatusState.error:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.errorMessage, textAlign: TextAlign.center),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => context.read<CharacterBloc>().add(
                              GetCharactersEvent(
                                name: state.currentNameFilter,
                                status: state.currentStatusFilter,
                                species: state.currentSpeciesFilter,
                                type: state.currentTypeFilter,
                                gender: state.currentGenderFilter,
                              ),
                            ),
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    );
                  case CharacterStatusState.success:
                  case CharacterStatusState.loadingMore:
                    if (state.characters.isEmpty) {
                      return const Center(
                        child: Text('No se encontraron personajes.'),
                      );
                    }

                    return ListView.builder(
                      key: const PageStorageKey<String>(
                        'character-list-scroll',
                      ),
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount:
                          state.status == CharacterStatusState.loadingMore
                          ? state.characters.length + 1
                          : state.characters.length,
                      itemBuilder: (final context, final index) {
                        if (index >= state.characters.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        }

                        final character = state.characters[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CharacterCard(
                            character: character,
                            isFavorite: state.isFavorite(character.id),
                            onFavoriteTap: () {
                              context.read<CharacterBloc>().add(
                                ToggleFavoriteCharacterEvent(
                                  character: character,
                                ),
                              );
                            },
                            onTap: () {
                              final characterBloc = context
                                  .read<CharacterBloc>();
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (final routeContext) =>
                                      BlocProvider.value(
                                        value: characterBloc,
                                        child: CharacterDetailPage(
                                          character: character,
                                        ),
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterFilterBar extends StatelessWidget {
  final VoidCallback onOpenFilters;
  final VoidCallback onClearFilters;

  const CharacterFilterBar({
    required this.onOpenFilters,
    required this.onClearFilters,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<CharacterBloc, CharacterState, CharacterState>(
      selector: (final state) => state,
      builder: (final context, final state) {
        final activeFilters = _buildActiveFiltersSummary(state);
        final hasAdvancedFilters =
            state.currentStatusFilter != null ||
            state.currentGenderFilter != null ||
            state.currentSpeciesFilter.isNotEmpty ||
            state.currentTypeFilter.isNotEmpty;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
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
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onOpenFilters,
                      icon: const Icon(Icons.tune),
                      label: Text(
                        hasAdvancedFilters
                            ? 'Filtros avanzados (${_advancedFilterCount(state)})'
                            : 'Filtros avanzados',
                      ),
                    ),
                  ),
                  if (hasAdvancedFilters) ...[
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: onClearFilters,
                      child: const Text('Limpiar'),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                activeFilters,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
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

String _buildActiveFiltersSummary(final CharacterState state) {
  final filters = <String>[];

  if (state.currentStatusFilter != null) {
    filters.add('Estado: ${state.currentStatusFilter!.displayName}');
  }
  if (state.currentGenderFilter != null) {
    filters.add('Género: ${state.currentGenderFilter!.displayName}');
  }
  if (state.currentSpeciesFilter.isNotEmpty) {
    filters.add('Especie: ${state.currentSpeciesFilter}');
  }
  if (state.currentTypeFilter.isNotEmpty) {
    filters.add('Tipo: ${state.currentTypeFilter}');
  }

  if (filters.isEmpty) {
    return 'Sin filtros avanzados aplicados';
  }

  return filters.join('  •  ');
}
