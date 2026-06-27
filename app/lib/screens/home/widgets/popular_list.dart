import 'package:flutter/material.dart';

import '../../../routers/app_routes.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/place_card.dart';
import '../../../widgets/section_title.dart';

class PopularList extends StatelessWidget {
  const PopularList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Mais populares',
          actionText: 'Ver mais',
          onActionTap: () {
            Navigator.pushNamed(context, AppRoutes.search);
          },
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              PlaceCard(
                title: 'Congresso Nacional',
                category: 'Monumento',
                distance: '800 m',
                rating: 4.9,
                icon: Icons.location_city,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.placeDetails);
                },
              ),
              PlaceCard(
                title: 'Pontão do Lago Sul',
                category: 'Lazer',
                distance: '5,1 km',
                rating: 4.8,
                icon: Icons.water,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.placeDetails);
                },
              ),
              PlaceCard(
                title: 'Torre de TV',
                category: 'Turismo',
                distance: '2,0 km',
                rating: 4.6,
                icon: Icons.tour,
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