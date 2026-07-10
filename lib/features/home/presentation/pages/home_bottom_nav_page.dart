import 'package:flutter/material.dart';
import 'package:morty_app/features/character/presentation/pages/character_list_page.dart';
import 'package:morty_app/features/location/presentation/pages/location_list_page.dart';

class HomeBottomNavPage extends StatefulWidget {
  const HomeBottomNavPage({super.key});

  @override
  State<HomeBottomNavPage> createState() => _HomeBottomNavPageState();
}

class _HomeBottomNavPageState extends State<HomeBottomNavPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    const CharacterListPage(),
    const LocationListPage(),
    const _EpisodesPlaceholderPage(),
    const _FavoritesPlaceholderPage(),
  ];

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
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
    );
  }
}

class _EpisodesPlaceholderPage extends StatelessWidget {
  const _EpisodesPlaceholderPage();

  @override
  Widget build(final BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Seccion de episodios: pendiente de implementacion.'),
      ),
    );
  }
}

class _FavoritesPlaceholderPage extends StatelessWidget {
  const _FavoritesPlaceholderPage();

  @override
  Widget build(final BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Favoritos: pendiente de implementacion.')),
    );
  }
}
