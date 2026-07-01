import 'package:flutter/material.dart';

import '../../models/place.dart';
import '../../routers/app_routes.dart';
import '../../services/favorite_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/place_card.dart';
import '../../widgets/section_title.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoriteService _favoriteService = FavoriteService();

  Future<List<Place>>? _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoritesFuture = _favoriteService.getFavorites();
  }

  void _openPlace(Place place) {
    Navigator.pushNamed(
      context,
      AppRoutes.placeDetails,
      arguments: place.id,
    );
  }

  Future<void> _removeFavorite(Place place) async {
    try {
      await _favoriteService.removeFavorite(place.id);

      setState(() {
        _loadFavorites();
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Removido dos favoritos.'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao remover favorito: $e'),
        ),
      );
    }
  }

  IconData _getIcon(String category) {
    final text = category.toLowerCase();

    if (text.contains('parque')) return Icons.park;
    if (text.contains('monumento')) return Icons.location_city;
    if (text.contains('gastronomia')) return Icons.restaurant;
    if (text.contains('evento')) return Icons.event;
    if (text.contains('compras')) return Icons.shopping_bag;
    if (text.contains('cultura')) return Icons.account_balance;
    if (text.contains('hotel')) return Icons.hotel;

    return Icons.place;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: FutureBuilder<List<Place>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (_favoritesFuture == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(
              message: 'Carregando favoritos...',
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'Erro ao carregar favoritos: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final favorites = snapshot.data ?? [];

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'Seus locais favoritos'),
                const SizedBox(height: AppSpacing.lg),
                if (favorites.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Você ainda não possui favoritos.',
                        style: AppTextStyles.small,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: favorites.length,
                      separatorBuilder: (_, __) {
                        return const SizedBox(height: AppSpacing.md);
                      },
                      itemBuilder: (context, index) {
                        final place = favorites[index];

                        return Dismissible(
                          key: ValueKey(place.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) => _removeFavorite(place),
                          child: PlaceCard(
                            title: place.title,
                            category: place.category.isEmpty
                                ? 'Sem categoria'
                                : place.category,
                            distance:
                                place.distance.isEmpty ? '--' : place.distance,
                            rating: place.rating,
                            icon: _getIcon(place.category),
                            onTap: () => _openPlace(place),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}