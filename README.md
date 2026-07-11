# Morty App

Aplicación Flutter que consume la Rick and Morty API y permite explorar personajes, episodios y locaciones. Incluye búsqueda, paginación infinita, favoritos persistidos localmente y soporte de tema claro/oscuro.

---

## Funcionalidades

| Feature | Descripción |
| --- | --- |
| Personajes | Lista paginada con búsqueda por nombre y filtro por estado: alive, dead, unknown |
| Detalle de personaje | Imagen expandida con Hero animation, información completa y episodios en los que aparece |
| Favoritos | Guardar y quitar personajes favoritos, persistidos en SQLite |
| Episodios | Lista paginada con búsqueda por nombre y detalle con grid de personajes |
| Locaciones | Lista paginada con búsqueda por nombre y detalle con grid de residentes |
| Tema | Toggle claro/oscuro respetando el sistema como valor inicial |

---

## Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
flutter analyze
```

Requisitos: Flutter 3.x y Dart SDK `^3.8.1`.

---

## Arquitectura

### Clean Architecture por feature

```text
lib/
├── core/
│   ├── bloc/
│   ├── constants/
│   ├── database/
│   ├── di/
│   ├── errors/
│   ├── network/
│   └── theme/
└── features/
    └── [feature]/
        ├── data/
        ├── domain/
        └── presentation/
```

Cada feature es independiente: `domain` no depende de `data` ni de `presentation`. Los use cases actúan como punto de entrada desde la UI hacia la lógica de negocio.

### Flujo de datos

```text
UI -> Event -> Bloc/Cubit -> UseCase -> Repository
                                          |
                                          v
                                   RepositoryImpl
                                   /            \
                        RemoteDataSource     LocalDataSource
                              (Dio)              (SQLite)
```

### Manejo de errores

Todos los repositorios devuelven `Either<Failure, T>` usando `dartz`.

```dart
Failure
|- ServerFailure
|- NetworkFailure
`- CacheFailure
```

La UI consume el `Left` o el `Right`; no depende de excepciones para renderizar estados.

---

## Manejo de estado

Se usa `flutter_bloc`. La división entre `Bloc` y `Cubit` responde a la complejidad de cada flujo.

| Componente | Tipo | Razón |
| --- | --- | --- |
| `CharacterBloc` | Bloc | Maneja búsqueda, paginación y favoritos |
| `EpisodeListBloc` | Bloc | Maneja búsqueda y paginación |
| `LocationBloc` | Bloc | Maneja búsqueda y paginación |
| `EpisodeCubit` | Cubit | Carga episodios por IDs |
| `EpisodeCharactersCubit` | Cubit | Carga personajes por IDs |
| `ThemeCubit` | Cubit | Gestiona un único `ThemeMode` |

Los estados usan enums explícitos: `initial`, `loading`, `loadingMore`, `success`, `empty`, `error`.

### Debounce y cancelación

La búsqueda usa un transformer con `stream_transform` para aplicar debounce y cancelar requests anteriores cuando el usuario sigue escribiendo.

```dart
EventTransformer<E> restartableDebounce<E>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}
```

---

## Networking y persistencia

### API

- Base URL: `https://rickandmortyapi.com/api/`
- Cliente HTTP: `Dio`
- Timeouts de conexión y recepción: 10 segundos

### Modelos

Los modelos de `data` usan `freezed` y `json_serializable` para mantener inmutabilidad y facilitar parsing seguro.

### Favoritos en SQLite

Los favoritos se almacenan con `sqflite` en la tabla `favorite_characters`.

```sql
CREATE TABLE favorite_characters (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  status TEXT NOT NULL,
  species TEXT NOT NULL,
  type TEXT NOT NULL,
  gender TEXT NOT NULL,
  imageUrl TEXT NOT NULL,
  originName TEXT NOT NULL,
  locationName TEXT NOT NULL,
  originLocationId INTEGER,
  currentLocationId INTEGER,
  episodeCount INTEGER NOT NULL,
  episodeIds TEXT NOT NULL
)
```

`episodeIds` se serializa como CSV porque SQLite no tiene tipo array nativo y no se requieren consultas relacionales sobre esos IDs.

---

## Inyección de dependencias

Se usa `get_it` junto con `injectable`. Las dependencias se declaran con anotaciones y el grafo se genera con `build_runner`.

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## UI y tema

- Material 3 activado con `useMaterial3: true`
- `ColorScheme.fromSeed` para derivar el tema claro y oscuro
- `ThemeCubit` inicializado en `ThemeMode.system`
- `CharacterCard` como widget reutilizable y testeable
- `Hero` animations entre lista y detalle
- `CachedNetworkImage` con placeholder y fallback de error
- `IndexedStack` para preservar estado entre tabs

---

## Testing

### Cobertura actual

Hay tests de dominio, repositorio, datasource remoto, bloc y widgets clave.

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Qué se prueba

| Test | Qué verifica |
| --- | --- |
| `get_characters_test` | Delegación correcta del use case al repositorio |
| `character_repository_impl_test` | Mapeo de modelos a entidades y manejo de errores |
| `character_remote_data_source_test` | Parseo de API y manejo de 404 |
| `character_bloc_test` | Secuencias de estado y paginación |
| `episode_list_bloc_test` | Carga, búsqueda y límite de paginación |
| `location_bloc_test` | Carga y búsqueda de locaciones |
| `character_card_test` | Render y callbacks del widget |
| `theme_cubit_test` | Cambio de tema entre estados |

---

## Decisiones y trade-offs

### BLoC vs Riverpod

Se eligió `flutter_bloc` porque el flujo evento -> estado hace más explícitas las transiciones y simplifica los tests con `bloc_test`.

### `dartz` vs sealed classes propias

`Either` permite modelar éxito o error con una interfaz uniforme en repositorios y use cases. La alternativa con sealed classes propias era viable, pero agregaba más código repetitivo.

### `freezed` para modelos

El costo es depender de generación de código. El beneficio es contar con modelos inmutables, `copyWith` y comparaciones estructurales sin implementación manual.






