import 'package:flutter/material.dart';
import 'package:morty_app/core/di/injection.dart';
import 'package:morty_app/features/character/presentation/pages/character_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return const MaterialApp(home: CharacterListPage());
  }
}
