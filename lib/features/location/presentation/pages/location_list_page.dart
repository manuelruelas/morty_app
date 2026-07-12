import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_app/core/di/injection.dart';
import 'package:morty_app/core/theme/theme_toggle_action.dart';
import 'package:morty_app/features/location/presentation/bloc/location_bloc.dart';
import 'package:morty_app/features/location/presentation/bloc/location_event.dart';
import 'package:morty_app/features/location/presentation/bloc/location_state.dart';
import 'package:morty_app/features/location/presentation/pages/location_detail_page.dart';

class LocationListPage extends StatefulWidget {
  final String? initialName;

  const LocationListPage({super.key, this.initialName});

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    final initialName = widget.initialName?.trim();
    final normalizedInitialName =
        (initialName != null && initialName.isNotEmpty) ? initialName : null;

    if (normalizedInitialName != null) {
      _searchController.text = normalizedInitialName;
    }

    _locationBloc = getIt<LocationBloc>()
      ..add(GetLocationsEvent(name: normalizedInitialName));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = _locationBloc.state;
      if (state.status == LocationStatusState.loadingMore ||
          state.status == LocationStatusState.loading) {
        return;
      }
      _locationBloc.add(LoadNextLocationsPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => _locationBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lugares R&M'),
          actions: const [ThemeToggleAction()],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar lugar...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (final value) {
                  _locationBloc.add(GetLocationsEvent(name: value));
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<LocationBloc, LocationState>(
                builder: (final context, final state) {
                  switch (state.status) {
                    case LocationStatusState.initial:
                    case LocationStatusState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case LocationStatusState.empty:
                      return const Center(
                        child: Text('No se encontraron lugares.'),
                      );
                    case LocationStatusState.error:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.errorMessage,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _locationBloc.add(
                                GetLocationsEvent(
                                  name: state.currentNameFilter,
                                ),
                              ),
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      );
                    case LocationStatusState.success:
                    case LocationStatusState.loadingMore:
                      if (state.locations.isEmpty) {
                        return const Center(
                          child: Text('No se encontraron lugares.'),
                        );
                      }

                      return ListView.builder(
                        key: const PageStorageKey<String>(
                          'location-list-scroll',
                        ),
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount:
                            state.status == LocationStatusState.loadingMore
                            ? state.locations.length + 1
                            : state.locations.length,
                        itemBuilder: (final context, final index) {
                          if (index >= state.locations.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }

                          final location = state.locations[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _LocationCard(
                              name: location.name,
                              type: location.type,
                              dimension: location.dimension,
                              residentsCount: location.residentIds.length,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (final context) =>
                                        LocationDetailPage(location: location),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String name;
  final String type;
  final String dimension;
  final int residentsCount;
  final VoidCallback onTap;

  const _LocationCard({
    required this.name,
    required this.type,
    required this.dimension,
    required this.residentsCount,
    required this.onTap,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withAlpha(
              (0.5 * 255).toInt(),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.public,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$type • $dimension',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$residentsCount',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'residentes',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
