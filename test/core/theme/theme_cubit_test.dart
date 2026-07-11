import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:morty_app/core/theme/theme_cubit.dart';

void main() {
  late ThemeCubit cubit;

  setUp(() {
    cubit = ThemeCubit();
  });

  tearDown(() async {
    await cubit.close();
  });

  test('estado inicial es ThemeMode.system', () {
    expect(cubit.state, ThemeMode.system);
  });

  blocTest<ThemeCubit, ThemeMode>(
    'toglea a dark cuando está en system (en plataforma dark)',
    build: () => cubit,
    seed: () => ThemeMode.system,
    act: (final cubit) {
      cubit.toggleTheme(_MockBuildContext(platformBrightness: Brightness.dark));
    },
    expect: () => [ThemeMode.light],
  );

  blocTest<ThemeCubit, ThemeMode>(
    'alterna entre dark y light',
    build: () => cubit,
    seed: () => ThemeMode.dark,
    act: (final cubit) {
      cubit.toggleTheme(_MockBuildContext());
    },
    expect: () => [ThemeMode.light],
  );

  blocTest<ThemeCubit, ThemeMode>(
    'alterna de light a dark',
    build: () => cubit,
    seed: () => ThemeMode.light,
    act: (final cubit) {
      cubit.toggleTheme(_MockBuildContext());
    },
    expect: () => [ThemeMode.dark],
  );
}

class _MockBuildContext extends Fake implements BuildContext {
  final Brightness platformBrightness;

  _MockBuildContext({this.platformBrightness = Brightness.light});

  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({
    final Object? aspect,
  }) {
    if (T == MediaQuery) {
      // Devolvemos un MediaQueryData falso con el brillo que configuramos
      return MediaQuery(
            data: MediaQueryData(platformBrightness: platformBrightness),
            child: const SizedBox(),
          )
          as T;
    }
    return null;
  }

  @override
  InheritedElement?
  getElementForInheritedWidgetOfExactType<T extends InheritedWidget>() {
    return null;
  }

  @override
  DiagnosticsNode describeWidget(
    final String name, {
    final DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty,
  }) {
    return DiagnosticsNode.message('Mocked BuildContext');
  }

  @override
  DiagnosticsNode describeOwnershipChain(final String name) {
    return DiagnosticsNode.message('Mocked BuildContext');
  }

  @override
  Widget get widget => MediaQuery(
    data: MediaQueryData(platformBrightness: platformBrightness),
    child: const SizedBox(),
  );

  @override
  MediaQueryData get mediaQuery =>
      MediaQueryData(platformBrightness: platformBrightness);
}
