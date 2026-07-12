import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/bloc/app_bloc_observer.dart';
import 'package:morty_app/core/di/injection.dart';
import 'package:morty_app/core/theme/theme_cubit.dart';
import 'package:morty_app/features/home/presentation/pages/home_bottom_nav_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final context) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (final context, final themeMode) {
          return MaterialApp(
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            theme: ThemeCubit.lightTheme,
            darkTheme: ThemeCubit.darkTheme,
            home: const HomeBottomNavPage(),
          );
        },
      ),
    );
  }
}
