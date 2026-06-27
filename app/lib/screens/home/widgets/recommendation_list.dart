import 'package:flutter/material.dart';

import '../../../routers/app_routes.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/place_card.dart';
import '../../../widgets/section_title.dart';

class RecommendationList extends StatelessWidget {
  const RecommendationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Recomendados para você',
          actionText: 'Ver mais',
          onActionTap: () {
            Navigator.pushNamed(context, AppRoutes.search);
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        const Text(
          'Baseado nos seus interesses',
          style: TextStyle(fontSize: 13),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              PlaceCard(
                title: 'Catedral Metropolitana',
                category: 'Arquitetura',
                distance: '1,2 km',
                rating: 4.8,
                icon: Icons.account_balance,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.placeDetails);
                },
              ),
              PlaceCard(
                title: 'Museu Nacional',
                category: 'Cultura',
                distance: '900 m',
                rating: 4.7,
                icon: Icons.museum,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.placeDetails);
                },
              ),
              PlaceCard(
                title: 'Parque da Cidade',
                category: 'Natureza',
                distance: '2,4 km',
                rating: 4.9,
                icon: Icons.park,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.placeDetails);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}