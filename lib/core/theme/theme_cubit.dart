import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme(final BuildContext context) {
    if (state == ThemeMode.system) {
      // Detecta si el sistema operativo está en modo oscuro actualmente
      final isPlatformDark =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      emit(isPlatformDark ? ThemeMode.light : ThemeMode.dark);
    } else {
      emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
    }
  }

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.light,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.dark,
    ),
  );
}
