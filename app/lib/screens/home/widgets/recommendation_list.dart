import 'package:flutter/material.dart';

import '../../../models/place.dart';
import '../../../routers/app_routes.dart';
import '../../../services/place_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/place_card.dart';
import '../../../widgets/section_title.dart';

class RecommendationList extends StatefulWidget {
  const RecommendationList({super.key});

  @override
  State<RecommendationList> createState() => _RecommendationListState();
}

class _RecommendationListState extends State<RecommendationList> {
  final PlaceService _placeService = PlaceService();

  Future<List<Place>>? _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = _placeService.getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: _placesFuture,
      builder: (context, snapshot) {
        if (_placesFuture == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget(
            message: 'Carregando locais...',
          );
        }

        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Recomendados do Backend',
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          );
        }

        final places = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: 'Recomendados do Backend',
              actionText: 'Ver mais',
              onActionTap: () {
                Navigator.pushNamed(context, AppRoutes.search);
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Locais recebidos da API: ${places.length}',
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: AppSpacing.md),
            if (places.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Nenhum local foi retornado pelo backend.',
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
                      category:
                          place.category.isEmpty ? 'Sem categoria' : place.category,
                      distance: place.distance.isEmpty ? '--' : place.distance,
                      rating: place.rating,
                      icon: Icons.place,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.placeDetails);
                      },
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