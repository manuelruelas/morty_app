
# 🟢 Morty App — Rick & Morty Character Explorer

Una aplicación Flutter que permite explorar personajes de la serie **Rick and Morty** con búsqueda, filtros, paginación y navegación a detalle. Construida siguiendo **Clean Architecture** con inyección de dependencias, manejo robusto de errores y pruebas significativas.

<img height="500" alt="SimulatorScreenRecording-iPhone15ProMax-2026-07-11at19 35 07-ezgif com-video-to-gif-converter" src="https://github.com/user-attachments/assets/2b8371d7-ff64-4559-851c-10f61584beed" />

## 🎯 Características principales

✅ **Listado de personajes** con paginación infinita  
✅ **Búsqueda** por nombre (debounced 500ms)  
✅ **Filtros combinables**: estado (Vivo/Muerto/Desconocido), especie, tipo, género  
✅ **Detalle del personaje** con información completa y navegación a episodios/ubicaciones  
✅ **Favoritos persistentes** (SQLite)  
✅ **Tema claro/oscuro** con Material 3 + toggle y persistencia  
✅ **Manejo graceful del 404** como estado vacío (no como error)  
✅ **Reintento en errores** con feedback visual  
✅ **Carga de imágenes eficiente** con placeholders y caching  
✅ **Responsive** en teléfono y tablet

## 🏗️ Arquitectura

Implementada con **Clean Architecture** en tres capas:

```
lib/
├── core/
│   ├── bloc/             # BlocObserver global
│   ├── constants/        # Constantes del app
│   ├── database/         # SQLite (favoritos)
│   ├── di/               # inyección de dependencias (get_it + injectable)
│   ├── errors/           # FailureMapper, Failures
│   ├── network/          # Cliente Dio centralizado
│   └── theme/            # ThemeCubit (light/dark, persistencia)
└── features/
    ├── character/
    │   ├── data/
    │   │   ├── datasources/   # Remote (API) + Local (SQLite)
    │   │   ├── models/        # Freezed DTOs
    │   │   └── repositories/  # CharacterRepositoryImpl
    │   ├── domain/
    │   │   ├── entities/      # Entidades de negocio
    │   │   ├── repositories/  # Interfaces abstractas
    │   │   └── usecases/      # GetCharacters, GetCharacterById, ToggleFavorite
    │   └── presentation/
    │       ├── bloc/          # CharacterBloc (lista + filtros)
    │       ├── cubit/         # CharacterDetailCubit (detalle)
    │       ├── pages/         # CharacterListPage, CharacterDetailPage
    │       └── widgets/       # CharacterCard, FilterChips, etc.
    ├── episode/               # Misma estructura
    └── location/              # Misma estructura
```

### Decisiones arquitectónicas

| Decisión | Justificación |
|----------|---------------|
| **Bloc vs Cubit** | `CharacterBloc` maneja lista + filtros (múltiples eventos, lógica compleja). `CharacterDetailCubit` es stateless (una sola responsabilidad: fetch by id). |
| **Either<Failure, T>** | `dartz` para manejo funcional de errores sin excepciones. Ventaja: tipos explícitos a nivel compilación. |
| **Freezed** | Modelos inmutables + generar `copyWith`, `==`, `hashCode` automáticamente. Menos boilerplate. |
| **Debounce 500ms** | Balance entre UX (respuesta rápida) y carga del servidor. Evita disparar 20 requests por 20 caracteres. |
| **404 como estado vacío** | Rick & Morty API devuelve HTTP 404 cuando búsqueda no tiene resultados. Lo capturamos como `EmptyState` (no error). |
| **SharedPreferences para tema** | Tema es UI concern. SQLite es overkill. SharedPreferences simple y rápido. |
| **SQLite para favoritos** | Pequeño dataset local. Opción: json_serializable + local_storage (pero SQLite es escalable). |

## 📦 Dependencias

- **flutter_bloc** (9.1.1): State management
- **dio** (5.10.0): HTTP client (con automático retry si falla)
- **get_it** (9.2.1) + **injectable** (2.7.1): DI pattern
- **dartz** (0.10.1): Either, Task (functional programming)
- **freezed** (3.2.3): Code generation (immutable models)
- **sqflite** (2.4.2): SQLite local
- **shared_preferences** (2.3.2): Persistencia ligera (tema)
- **cached_network_image** (3.4.1): Caching de imágenes
- **stream_transform** (2.1.1): Transformers para Bloc (debounce)

**Dev:**
- **bloc_test** (10.0.0): Testing Bloc/Cubit
- **mocktail** (1.0.5): Mocks sin reflexión (ligero)
- **build_runner** (2.4.9): Code generation

## 🚀 Cómo ejecutar

### Requisitos previos
- Flutter 3.8+
- Dart 3.8+
- iOS 11+ ó Android API 21+

### Pasos

1. **Clonar el repo y instalar deps**
   ```bash
   git clone <repo>
   cd morty_app
   flutter pub get
   ```

2. **Generar código (DI + Models)**
   ```bash
   dart run build_runner build
   ```
   O para desarrollo (watch mode):
   ```bash
   dart run build_runner watch
   ```

3. **Ejecutar en dev**
   ```bash
   flutter run                    # Por defecto: Debug en conectado
   flutter run -d chrome         # Navegador (web aún no soportado oficialmente)
   ```

4. **Ejecutar tests**
   ```bash
   flutter test                   # Todos
   flutter test test/features/character    # Solo character feature
   ```

5. **Build release**
   ```bash
   flutter build apk              # Android
   flutter build ios               # iOS
   ```

## 🧪 Testing

**Cobertura: 57 tests en verde** (100%)

- ✅ **Unit tests** (data layer): datasources, repositories, use cases
- ✅ **Bloc/Cubit tests** (presentation logic)
- ✅ **Widget tests**: CharacterCard, filtros

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html  # Reporte HTML
```

Archivos clave:
- [test/features/character/data/datasources/remote/character_remote_data_source_test.dart](test/features/character/data/datasources/remote/character_remote_data_source_test.dart): Mock de Dio, edge cases (404, timeout)
- [test/features/character/data/repositories/character_repository_impl_test.dart](test/features/character/data/repositories/character_repository_impl_test.dart): Mapeo de errores, Either
- [test/features/character/presentation/bloc/character_bloc_test.dart](test/features/character/presentation/bloc/character_bloc_test.dart): Búsqueda, filtros, paginación
- [test/features/character/presentation/widgets/character_card_test.dart](test/features/character/presentation/widgets/character_card_test.dart): Interacción UI

## 🎨 UI & Tema

- **Material 3** con `ColorScheme.fromSeed` (dinámica en Android 12+)
- **Claro/Oscuro** con transición suave
- **Widgets reutilizables**:
  - `CharacterCard`: Tarjeta con imagen, nombre, estado, favorito
  - `StatusIndicator`: Badge con color según estado
  - `FilterChipsHeader`: Chips para filtrir por estado
- **Responsive**: Grid en desktop (2 cols), mobile (1 col)

## 📱 Flujo de navegación

```
Splash / Home
    ├── CharacterListPage
    │   ├── SearchBar (name) → debounce
    │   ├── FilterChips (status, species, type, gender)
    │   └── ListView + pagination
    │       └── CharacterCard → tap → CharacterDetailPage
    │
    ├── CharacterDetailPage
    │   ├── Imagen (Hero animation)
    │   ├── Info (estado, especie, género)
    │   ├── Origen + Ubicación actual
    │   ├── Episodios (grid of EpisodeCard)
    │   │   └── EpisodeCard → tap → EpisodeDetailPage
    │   └── Residentes (si es Location)
    │
    ├── EpisodeListPage (tab en bottom nav)
    │   └── Idem CharacterList
    │
    └── LocationListPage (tab en bottom nav)
        └── Idem CharacterList
```

## 🔄 Manejo de errores

**FailureMapper** centraliza la lógica:
- HTTP 404 → `Failure.notFound` → UI muestra "Sin resultados" (no error)
- HTTP 500 → `Failure.serverError` → UI muestra "Error del servidor. Reintentar."
- Network timeout → `Failure.networkError` → UI muestra "Sin conexión. Reintentar."
- `DioException` con automático retry (3 intentos por defecto)

```dart
// Ejemplo en repository
try {
  final result = await _remoteDataSource.getCharacters(...);
  return Right(result);
} catch (e) {
  return Left(FailureMapper.mapServerError(e, ...));
}
```

## 📊 States Explícitos

Cada feature modela `loading / success / error / empty`:

```dart
// CharacterStatusState (Bloc)
abstract class CharacterState extends Equatable {}
class CharacterInitial extends CharacterState {}
class CharacterLoading extends CharacterState {}
class CharacterSuccess extends CharacterState {
  final List<Character> characters;
  final bool hasMore;  // pagination
  ...
}
class CharacterEmpty extends CharacterState {}
class CharacterError extends CharacterState {
  final String message;
}
```

UI reacciona con BlocBuilder/BlocListener:
```dart
BlocBuilder<CharacterBloc, CharacterState>(
  builder: (_, state) {
    if (state is CharacterLoading) return LoadingShimmer();
    if (state is CharacterEmpty) return EmptyWidget();
    if (state is CharacterError) return ErrorWidget(msg: state.message, onRetry: ...);
    if (state is CharacterSuccess) return CharacterList(...);
  }
)
```

## 🗂️ Git Workflow

**Branching strategy:**
- `main`: producción (merge de releases tagged)
- `dev`: desarrollo (integración)
- `feat/*`: features nuevas
- `fix/*`: bugfixes
- `test/*`: cambios en tests
- `refac/*`: refactorizaciones
- `doc/*`: documentación

**Commits:**
- Descripción clara en español/inglés
- Ej: `feat: add character filtering by species and type (#18)`

Ejemplo reciente:
```
a937bc5 Refactor character pages and enhance character name display (#22)
87d361f Add initial character name and image URL to CharacterDetailPage (#21)
2e18805 Save theme preferences (#20)
```

## 🐛 Casos límite manejados

- ✅ **404 en búsqueda**: "Sin resultados" (no error)
- ✅ **Timeout de red**: Reintento automático + botón manual
- ✅ **Imagen no carga**: Placeholder + error fallback
- ✅ **Lista vacía (API)**: Empty state, no spinner infinito
- ✅ **Scroll al final**: Carga siguiente página automática
- ✅ **Cambio de filtro**: Reset a página 1, mantén scroll position
- ✅ **Favorito sin conexión**: SQLite local (no sincroniza)
- ✅ **Tema cambia**: Persistencia + rebuild automático

## 📈 Performance

- **Paginación**: Evita cargar 800 personajes de golpe
- **Debounce búsqueda**: No dispara requests por cada carácter
- **Imagen caching**: `cached_network_image` + disco
- **Bloc + stream_transform**: Event consolidation (no duplicar requests)
- **Lazy loading**: Bloc/Cubit carga datos bajo demanda

## ⚠️ Trade-offs

| Aspecto | Decisión | Trade-off |
|--------|----------|-----------|
| **Bloc vs Riverpod** | Bloc + Cubit | Más boilerplate, pero mejor para equipos grandes. Riverpod es más "functional" pero ↑ curva. |
| **Dio vs http** | Dio | Más features (interceptors, retry), pero ↑ tamaño APK. http es minimal. |
| **Freezed vs dataclass** | Freezed | Generación automática, pero ↑ build_runner time. dataclass manual = corta el problema. |

## 📝 Calidad de código

```bash
# Lint (cero warnings)
flutter analyze
# Output: No issues found!

# Tests (verde)
flutter test
# Output: All tests passed! (57)

# Formatting
dart format lib test --set-exit-if-changed
```

## 🤖 Uso de IA

Ver [USO_IA.md](USO_IA.md) para prompts concretos, casos de rechazo y qué se delegó a Copilot.

## 📚 Recursos

- [Rick & Morty API Docs](https://rickandmortyapi.com)
- [Flutter Bloc Pattern](https://bloclibrary.dev)
- [Clean Architecture en Flutter](https://medium.com/flutter-community/clean-architecture-in-flutter)
- [Freezed Package](https://pub.dev/packages/freezed)

---

**Last updated**: Julio 2026  
**Autor**: Manuel Ruelas  
