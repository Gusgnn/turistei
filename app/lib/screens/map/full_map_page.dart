import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../models/place.dart';
import '../../routers/app_routes.dart';
import '../../services/place_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/loading_widget.dart';

class FullMapPage extends StatefulWidget {
  const FullMapPage({super.key});

  @override
  State<FullMapPage> createState() => _FullMapPageState();
}

class _FullMapPageState extends State<FullMapPage> {
  final PlaceService _placeService = PlaceService();
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  Future<List<Place>>? _placesFuture;

  Place? _selectedPlace;
  String? _initialPlaceId;

  String _search = '';
  String _selectedCategory = 'Todas';

  static const LatLng _brasiliaCenter = LatLng(-15.793889, -47.882778);

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is String && _initialPlaceId == null) {
      _initialPlaceId = args;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadPlaces() {
    _placesFuture = _placeService.getPlaces();
  }

  void _reload() {
    setState(() {
      _selectedPlace = null;
      _search = '';
      _selectedCategory = 'Todas';
      _searchController.clear();
      _loadPlaces();
    });

    _mapController.move(_brasiliaCenter, 13);
  }

  List<Place> _validPlaces(List<Place> places) {
    return places.where((place) {
      return place.latitude != 0 && place.longitude != 0;
    }).toList();
  }

  List<String> _categories(List<Place> places) {
    final categories = places
        .map((place) => place.category.trim())
        .where((category) => category.isNotEmpty)
        .toSet()
        .toList();

    categories.sort();

    return ['Todas', ...categories];
  }

  List<Place> _filteredPlaces(List<Place> places) {
    return _validPlaces(places).where((place) {
      final matchesSearch = _search.isEmpty ||
          place.title.toLowerCase().contains(_search) ||
          place.category.toLowerCase().contains(_search);

      final matchesCategory =
          _selectedCategory == 'Todas' || place.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _selectPlace(Place place) {
    setState(() {
      _selectedPlace = place;
    });

    _mapController.move(
      LatLng(place.latitude, place.longitude),
      15,
    );
  }

  void _openPlaceDetails(Place place) {
    Navigator.pushNamed(
      context,
      AppRoutes.placeDetails,
      arguments: place.id,
    );
  }

  Widget _buildPlaceImage(Place place, {double size = 72}) {
    if (place.imageUrl.isEmpty) {
      return _buildImagePlaceholder(size);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        place.imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _buildImagePlaceholder(size);
        },
      ),
    );
  }

  Widget _buildImagePlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.image_outlined,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildMarker(Place place) {
    final selected = _selectedPlace?.id == place.id;

    return GestureDetector(
      onTap: () => _selectPlace(place),
      child: AnimatedScale(
        scale: selected ? 1.18 : 1,
        duration: const Duration(milliseconds: 180),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.location_pin,
              color: selected ? AppColors.secondary : AppColors.primary,
              size: selected ? 56 : 46,
            ),
            Positioned(
              top: 8,
              child: ClipOval(
                child: place.imageUrl.isEmpty
                    ? Container(
                        width: 22,
                        height: 22,
                        color: Colors.white,
                        child: const Icon(
                          Icons.place,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      )
                    : Image.network(
                        place.imageUrl,
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            width: 22,
                            height: 22,
                            color: Colors.white,
                            child: const Icon(
                              Icons.place,
                              size: 14,
                              color: AppColors.primary,
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters(List<Place> places) {
    final categories = _categories(_validPlaces(places));

    return Positioned(
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      child: Column(
        children: [
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(18),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar no mapa...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _search = '';
                            _selectedPlace = null;
                            _searchController.clear();
                          });
                        },
                      ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _search = value.trim().toLowerCase();
                  _selectedPlace = null;
                });
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final selected = category == _selectedCategory;

                return ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  selectedColor: AppColors.primary.withOpacity(0.18),
                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = category;
                      _selectedPlace = null;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedPlaceCard() {
    final place = _selectedPlace;

    if (place == null) {
      return const SizedBox.shrink();
    }

    return Positioned(
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      bottom: 122,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _openPlaceDetails(place),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                _buildPlaceImage(place),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(place.title, style: AppTextStyles.subtitle),
                      const SizedBox(height: 4),
                      Text(
                        place.category.isEmpty
                            ? 'Sem categoria'
                            : place.category,
                        style: AppTextStyles.small,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            place.rating > 0 ? place.rating.toString() : '-',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPlaceList(List<Place> places) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 108,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.14),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: places.isEmpty
            ? const Center(
                child: Text(
                  'Nenhum local encontrado no mapa.',
                  style: AppTextStyles.small,
                ),
              )
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: places.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) {
                  final place = places[index];
                  final selected = _selectedPlace?.id == place.id;

                  return GestureDetector(
                    onTap: () => _selectPlace(place),
                    onDoubleTap: () => _openPlaceDetails(place),
                    child: Container(
                      width: 245,
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary.withOpacity(0.12)
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildPlaceImage(place, size: 64),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  place.category.isEmpty
                                      ? 'Sem categoria'
                                      : place.category,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.small,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildMap(List<Place> places) {
    final filteredPlaces = _filteredPlaces(places);

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
            initialCenter: _brasiliaCenter,
            initialZoom: 13,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'br.com.turistei',
            ),
            MarkerLayer(
              markers: filteredPlaces.map((place) {
                return Marker(
                  point: LatLng(place.latitude, place.longitude),
                  width: 64,
                  height: 64,
                  child: _buildMarker(place),
                );
              }).toList(),
            ),
          ],
        ),
        _buildSearchAndFilters(places),
        Positioned(
          top: 124,
          right: AppSpacing.md,
          child: Column(
            children: [
              FloatingActionButton.small(
                heroTag: 'reload-map',
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                onPressed: _reload,
                child: const Icon(Icons.refresh),
              ),
              const SizedBox(height: AppSpacing.sm),
              FloatingActionButton.small(
                heroTag: 'center-map',
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                onPressed: () {
                  setState(() {
                    _selectedPlace = null;
                  });

                  _mapController.move(_brasiliaCenter, 13);
                },
                child: const Icon(Icons.center_focus_strong),
              ),
            ],
          ),
        ),
        if (_validPlaces(places).isEmpty)
          const Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'Nenhum local com coordenadas encontrado.',
                  style: AppTextStyles.small,
                ),
              ),
            ),
          ),
        _buildSelectedPlaceCard(),
        _buildBottomPlaceList(filteredPlaces),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mapa Turistei'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Place>>(
        future: _placesFuture,
        builder: (context, snapshot) {
          if (_placesFuture == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(message: 'Carregando mapa...');
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Erro ao carregar locais: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          final places = snapshot.data ?? [];

          if (_initialPlaceId != null && _selectedPlace == null) {
            final matches = places.where(
              (place) => place.id == _initialPlaceId,
            );

            if (matches.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                _selectPlace(matches.first);
              });
            }
          }

          return _buildMap(places);
        },
      ),
    );
  }
}