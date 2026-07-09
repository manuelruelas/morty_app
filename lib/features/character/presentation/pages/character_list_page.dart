import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/di/injection.dart';
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
  late CharacterBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _characterBloc = getIt<CharacterBloc>()..add(const GetCharactersEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = _characterBloc.state;
      if (state.status == CharacterStatusState.loadingMore ||
          state.status == CharacterStatusState.loading) {
        return;
      }
      _characterBloc.add(LoadNextPageEvent());
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
    return BlocProvider(
      create: (final _) => _characterBloc,
      child: Scaffold(
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar personaje...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (final value) {
                  _characterBloc.add(
                    GetCharactersEvent(
                      name: value,
                      status: _characterBloc.state.currentStatusFilter,
                    ),
                  );
                },
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
                            Text(
                              state.errorMessage,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _characterBloc.add(
                                GetCharactersEvent(
                                  name: state.currentNameFilter,
                                  status: state.currentStatusFilter,
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
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }

                          final character = state.characters[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: CharacterCard(
                              character: character,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (final context) =>
                                        CharacterDetailPage(
                                          character: character,
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
      ),
    );
  }
}

class FilterChipsHeader extends StatelessWidget {
  const FilterChipsHeader({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<CharacterBloc, CharacterState, CharacterStatus?>(
      selector: (final state) {
        return state.currentStatusFilter;
      },
      builder: (final context, final state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              ChoiceChip(
                label: const Text('Todos'),
                selected: state == null,
                onSelected: (final selected) {
                  final bloc = context.read<CharacterBloc>();
                  bloc.add(
                    GetCharactersEvent(
                      name: bloc.state.currentNameFilter,
                      status: null,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              ...CharacterStatus.values.map((final status) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(status.displayName),
                    selected: state == status,
                    onSelected: (final selected) {
                      final bloc = context.read<CharacterBloc>();
                      bloc.add(
                        GetCharactersEvent(
                          name: bloc.state.currentNameFilter,
                          status: selected ? status : null,
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
