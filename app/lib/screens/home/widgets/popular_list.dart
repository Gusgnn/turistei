import 'package:flutter/material.dart';

import '../../../models/place.dart';
import '../../../routers/app_routes.dart';
import '../../../services/place_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/place_card.dart';
import '../../../widgets/section_title.dart';

class PopularList extends StatefulWidget {
  const PopularList({super.key});

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  final PlaceService _placeService = PlaceService();

  Future<List<Place>>? _popularFuture;

  @override
  void initState() {
    super.initState();
    _popularFuture = _placeService.getPopularPlaces();
  }

  void _openPlace(Place place) {
    Navigator.pushNamed(
      context,
      AppRoutes.placeDetails,
      arguments: place.id,
    );
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
    return FutureBuilder<List<Place>>(
      future: _popularFuture,
      builder: (context, snapshot) {
        if (_popularFuture == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget(
            message: 'Carregando locais populares...',
          );
        }

        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Mais populares',
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ],
          );
        }

        final places = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: 'Mais populares',
              actionText: 'Ver mais',
              onActionTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.search,
                );
              },
            ),

            const SizedBox(height: AppSpacing.md),

            if (places.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Nenhum local popular encontrado.',
                  ),
                ),
              )
            else
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    final place = places[index];

                    return PlaceCard(
                      title: place.title,
                      category: place.category.isEmpty
                          ? 'Sem categoria'
                          : place.category,
                      distance: place.distance.isEmpty
                          ? '--'
                          : place.distance,
                      rating: place.rating,
                      icon: _getIcon(place.category),
                      onTap: () => _openPlace(place),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}