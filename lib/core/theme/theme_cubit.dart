import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _loadSavedThemeMode();
  }

  static const String _themeModeKey = 'theme_mode';

  Future<void> _loadSavedThemeMode() async {
    final preferences = await SharedPreferences.getInstance();
    final savedValue = preferences.getString(_themeModeKey);
    final savedMode = _themeModeFromString(savedValue);

    if (savedMode != null && savedMode != state) {
      emit(savedMode);
    }
  }

  Future<void> toggleTheme(final BuildContext context) async {
    final nextMode = _nextThemeMode(context);
    emit(nextMode);

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_themeModeKey, _themeModeToString(nextMode));
  }

  ThemeMode _nextThemeMode(final BuildContext context) {
    if (state == ThemeMode.system) {
      final isPlatformDark =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      return isPlatformDark ? ThemeMode.light : ThemeMode.dark;
    }

    return state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  String _themeModeToString(final ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
    }
  }

  ThemeMode? _themeModeFromString(final String? value) {
    switch (value) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return null;
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
