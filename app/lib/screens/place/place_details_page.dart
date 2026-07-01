import 'package:flutter/material.dart';

import '../../models/place.dart';
import '../../services/favorite_service.dart';
import '../../services/place_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../routers/app_routes.dart';
import '../../widgets/app_button.dart';

class PlaceDetailsPage extends StatefulWidget {
  const PlaceDetailsPage({super.key});

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  final PlaceService _placeService = PlaceService();
  final FavoriteService _favoriteService = FavoriteService();

  Future<Place>? _placeFuture;

  bool _isFavorite = false;
  bool _favoriteLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_placeFuture != null) return;

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is String) {
      _placeFuture = _placeService.getPlaceById(args);
      _checkFavorite(args);
    }
  }

  Future<void> _checkFavorite(String placeId) async {
    try {
      final favorites = await _favoriteService.getFavorites();

      if (!mounted) return;

      setState(() {
        _isFavorite = favorites.any((place) => place.id == placeId);
      });
    } catch (_) {
      // Se não conseguir verificar, apenas deixa como não favoritado.
    }
  }

  Future<void> _toggleFavorite(Place place) async {
    if (_favoriteLoading) return;

    setState(() {
      _favoriteLoading = true;
    });

    try {
      if (_isFavorite) {
        await _favoriteService.removeFavorite(place.id);
      } else {
        await _favoriteService.addFavorite(place.id);
      }

      if (!mounted) return;

      setState(() {
        _isFavorite = !_isFavorite;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isFavorite
                ? 'Adicionado aos favoritos.'
                : 'Removido dos favoritos.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar favorito: $e'),
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _favoriteLoading = false;
      });
    }
  }

  Widget _buildPlaceImage(Place place) {
    if (place.imageUrl.isEmpty) {
      return _buildImagePlaceholder();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.network(
        place.imageUrl,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _buildImagePlaceholder();
        },
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 48,
            color: AppColors.primary,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Imagem não disponível',
            style: AppTextStyles.small,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Detalhes do local'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _placeFuture == null
          ? const Center(
              child: Text('Local não informado.'),
            )
          : FutureBuilder<Place>(
              future: _placeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        'Erro ao carregar local: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                final place = snapshot.data!;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPlaceImage(place),

                      const SizedBox(height: AppSpacing.lg),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              place.title,
                              style: AppTextStyles.title,
                            ),
                          ),
                          IconButton(
                            onPressed: _favoriteLoading
                                ? null
                                : () => _toggleFavorite(place),
                            icon: _favoriteLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    _isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: AppColors.primary,
                                  ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        place.category.isEmpty
                            ? 'Sem categoria'
                            : place.category,
                        style: AppTextStyles.small,
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildInfoChip(
                            icon: Icons.star,
                            text: place.rating > 0
                                ? place.rating.toString()
                                : '-',
                            color: Colors.amber,
                          ),
                          _buildInfoChip(
                            icon: Icons.location_on,
                            text: place.distance.isEmpty
                                ? '--'
                                : place.distance,
                            color: AppColors.primary,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      const Text(
                        'Descrição',
                        style: AppTextStyles.subtitle,
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        place.description.isEmpty
                            ? 'Sem descrição cadastrada.'
                            : place.description,
                        style: AppTextStyles.body,
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      const Text(
                        'Localização',
                        style: AppTextStyles.subtitle,
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        'Latitude: ${place.latitude}',
                        style: AppTextStyles.small,
                      ),
                      Text(
                        'Longitude: ${place.longitude}',
                        style: AppTextStyles.small,
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      if (place.tags.isNotEmpty) ...[
                        const Text(
                          'Tags',
                          style: AppTextStyles.subtitle,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: place.tags.map((tag) {
                            return Chip(
                              label: Text(tag),
                            );
                          }).toList(),
                        ),
                      ],

                      const SizedBox(height: AppSpacing.lg),

                        AppButton(
                          text: 'Ver no mapa',
                          icon: Icons.map_outlined,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.fullMap,
                              arguments: place.id,
                            );
                          },
                        ),

                      const SizedBox(height: AppSpacing.lg),

                      AppButton(
                        text: 'Ver avaliações',
                        icon: Icons.star_outline,
                        onPressed: () async {
                          await Navigator.pushNamed(
                            context,
                            AppRoutes.reviews,
                            arguments: place.id,
                          );

                          if (!mounted) return;

                          setState(() {
                            _placeFuture = _placeService.getPlaceById(place.id);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}