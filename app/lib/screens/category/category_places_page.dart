import 'package:flutter/material.dart';

import '../../models/category.dart';
import '../../models/place.dart';
import '../../routers/app_routes.dart';
import '../../services/place_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/place_card.dart';

class CategoryPlacesPage extends StatefulWidget {
  const CategoryPlacesPage({super.key});

  @override
  State<CategoryPlacesPage> createState() => _CategoryPlacesPageState();
}

class _CategoryPlacesPageState extends State<CategoryPlacesPage> {
  final PlaceService _placeService = PlaceService();

  Category? _category;
  Future<List<Place>>? _placesFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_placesFuture != null) return;

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Category) {
      _category = args;
      _placesFuture = _loadPlacesByCategory(args);
    } else {
      _placesFuture = _placeService.getPlaces();
    }
  }

  Future<List<Place>> _loadPlacesByCategory(Category category) async {
    final backendPlaces = await _placeService.getPlacesByCategory(category.id);

    if (backendPlaces.isNotEmpty) {
      return backendPlaces;
    }

    final allPlaces = await _placeService.getPlaces();

    return allPlaces.where((place) {
      return place.category.toLowerCase().trim() ==
          category.name.toLowerCase().trim();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final title = _category?.name ?? 'Locais';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Place>>(
        future: _placesFuture,
        builder: (context, snapshot) {
          if (_placesFuture == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'Erro ao carregar locais: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final places = snapshot.data ?? [];

          if (places.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum local encontrado.',
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
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.placeDetails,
                    arguments: place.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}