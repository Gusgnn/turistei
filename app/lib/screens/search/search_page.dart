import 'package:flutter/material.dart';

import '../../models/place.dart';
import '../../routers/app_routes.dart';
import '../../services/place_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/place_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PlaceService _placeService = PlaceService();
  final TextEditingController _searchController = TextEditingController();

  Future<List<Place>>? _placesFuture;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    _placesFuture = _placeService.getPlaces();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchPlaces(String query) {
    final text = query.trim();

    setState(() {
      _lastQuery = text;

      if (text.isEmpty) {
        _placesFuture = _placeService.getPlaces();
      } else {
        _placesFuture = _placeService.searchPlaces(text);
      }
    });
  }

  void _openPlaceDetails(Place place) {
    Navigator.pushNamed(
      context,
      AppRoutes.placeDetails,
      arguments: place.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: TextField(
              controller: _searchController,
              onChanged: _searchPlaces,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: 'Pesquisar locais...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          _searchPlaces('');
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Place>>(
              future: _placesFuture,
              builder: (context, snapshot) {
                if (_placesFuture == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(
                    message: 'Buscando locais...',
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        'Erro ao buscar locais: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                final places = snapshot.data ?? [];

                if (places.isEmpty) {
                  return Center(
                    child: Text(
                      _lastQuery.isEmpty
                          ? 'Nenhum local encontrado.'
                          : 'Nenhum resultado para "$_lastQuery".',
                      style: AppTextStyles.small,
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: places.length,
                  separatorBuilder: (_, __) {
                    return const SizedBox(height: AppSpacing.md);
                  },
                  itemBuilder: (context, index) {
                    final place = places[index];

                    return PlaceCard(
                      title: place.title,
                      category: place.category.isEmpty
                          ? 'Sem categoria'
                          : place.category,
                      distance: place.distance.isEmpty ? '--' : place.distance,
                      rating: place.rating,
                      icon: Icons.place,
                      onTap: () => _openPlaceDetails(place),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}