import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/di/injection.dart';
import 'package:morty_app/features/character/presentation/bloc/character_bloc.dart';
import 'package:morty_app/features/character/presentation/bloc/character_event.dart';
import 'package:morty_app/features/character/presentation/pages/character_list_page.dart';
import 'package:morty_app/features/character/presentation/pages/favorite_characters_page.dart';
import 'package:morty_app/features/episode/presentation/pages/episode_list_page.dart';
import 'package:morty_app/features/location/presentation/pages/location_list_page.dart';

class HomeBottomNavPage extends StatefulWidget {
  const HomeBottomNavPage({super.key});

  @override
  State<HomeBottomNavPage> createState() => _HomeBottomNavPageState();
}

class _HomeBottomNavPageState extends State<HomeBottomNavPage> {
  int _currentIndex = 0;
  late final CharacterBloc _characterBloc;

  late final List<Widget> _pages = [
    const CharacterListPage(),
    const LocationListPage(),
    const EpisodeListPage(),
    const FavoriteCharactersPage(),
  ];

  @override
  void initState() {
    super.initState();
    _characterBloc = getIt<CharacterBloc>()
      ..add(const GetCharactersEvent())
      ..add(const LoadFavoriteCharactersEvent());
  }

  @override
  void dispose() {
    _characterBloc.close();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final pagesWithHeroMode = List<Widget>.generate(_pages.length, (
      final index,
    ) {
      return HeroMode(enabled: index == _currentIndex, child: _pages[index]);
    });

    return BlocProvider<CharacterBloc>.value(
      value: _characterBloc,
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: pagesWithHeroMode),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (final index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Personajes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public_outlined),
              activeIcon: Icon(Icons.public),
              label: 'Lugares',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv_outlined),
              activeIcon: Icon(Icons.tv),
              label: 'Episodios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
          ],
        ),
      ),
    );
  }
}
