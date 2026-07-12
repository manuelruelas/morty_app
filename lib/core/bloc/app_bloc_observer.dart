// ignore_for_file: strict_raw_type

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(final BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      print('🟢 Bloc Creado: ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(final Bloc bloc, final Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('🔵 Evento Añadido en [${bloc.runtimeType}]: $event');
    }
  }

  @override
  void onTransition(final Bloc bloc, final Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('🔄 Transición en [${bloc.runtimeType}]:');
      print('   👉 Estado Anterior: ${transition.currentState}');
      print('   ⚡ Evento disparador: ${transition.event}');
      print('   👈 Estado Siguiente: ${transition.nextState}');
    }
  }

  @override
  void onError(
    final BlocBase bloc,
    final Object error,
    final StackTrace stackTrace,
  ) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print('🔴 Error en [${bloc.runtimeType}]: $error');
    }
  }

  @override
  void onClose(final BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      print('⚪ Bloc Cerrado: ${bloc.runtimeType}');
    }
  }
}
