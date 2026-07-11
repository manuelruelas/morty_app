import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/theme/theme_cubit.dart';

class ThemeToggleAction extends StatelessWidget {
  final Color? iconColor;

  const ThemeToggleAction({super.key, this.iconColor});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (final context, final themeMode) {
        final isDark = themeMode == ThemeMode.dark;

        return IconButton(
          tooltip: isDark ? 'Cambiar a tema claro' : 'Cambiar a tema oscuro',
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          color: iconColor,
          onPressed: () {
            context.read<ThemeCubit>().toggleTheme(context);
          },
        );
      },
    );
  }
}
