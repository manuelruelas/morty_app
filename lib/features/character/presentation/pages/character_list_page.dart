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
                TextField(
                  controller: _speciesController,
                  decoration: InputDecoration(
                    hintText: 'Filtrar por especie...',
                    prefixIcon: const Icon(Icons.pets),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (final value) => _applyFilters(),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _typeController,
                  decoration: InputDecoration(
                    hintText: 'Filtrar por tipo...',
                    prefixIcon: const Icon(Icons.category_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (final value) => _applyFilters(),
                ),
              ],
            ),
          ),
          const FilterChipsHeader(),
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

class FilterChipsHeader extends StatelessWidget {
  const FilterChipsHeader({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<CharacterBloc, CharacterState, CharacterState>(
      selector: (final state) => state,
      builder: (final context, final state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Estado', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Todos'),
                    selected: state.currentStatusFilter == null,
                    onSelected: (final selected) {
                      final bloc = context.read<CharacterBloc>();
                      bloc.add(
                        GetCharactersEvent(
                          name: bloc.state.currentNameFilter,
                          status: null,
                          species: bloc.state.currentSpeciesFilter,
                          type: bloc.state.currentTypeFilter,
                          gender: bloc.state.currentGenderFilter,
                        ),
                      );
                    },
                  ),
                  ...CharacterStatus.values.map((final status) {
                    return ChoiceChip(
                      label: Text(status.displayName),
                      selected: state.currentStatusFilter == status,
                      onSelected: (final selected) {
                        final bloc = context.read<CharacterBloc>();
                        bloc.add(
                          GetCharactersEvent(
                            name: bloc.state.currentNameFilter,
                            status: selected ? status : null,
                            species: bloc.state.currentSpeciesFilter,
                            type: bloc.state.currentTypeFilter,
                            gender: bloc.state.currentGenderFilter,
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
              const SizedBox(height: 12),
              Text('Género', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Todos'),
                    selected: state.currentGenderFilter == null,
                    onSelected: (final selected) {
                      final bloc = context.read<CharacterBloc>();
                      bloc.add(
                        GetCharactersEvent(
                          name: bloc.state.currentNameFilter,
                          status: bloc.state.currentStatusFilter,
                          species: bloc.state.currentSpeciesFilter,
                          type: bloc.state.currentTypeFilter,
                          gender: null,
                        ),
                      );
                    },
                  ),
                  ...CharacterGender.values.map((final gender) {
                    return ChoiceChip(
                      label: Text(gender.displayName),
                      selected: state.currentGenderFilter == gender,
                      onSelected: (final selected) {
                        final bloc = context.read<CharacterBloc>();
                        bloc.add(
                          GetCharactersEvent(
                            name: bloc.state.currentNameFilter,
                            status: bloc.state.currentStatusFilter,
                            species: bloc.state.currentSpeciesFilter,
                            type: bloc.state.currentTypeFilter,
                            gender: selected ? gender : null,
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
