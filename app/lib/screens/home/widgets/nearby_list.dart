import 'package:flutter/material.dart';

import '../../../routers/app_routes.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/place_card.dart';
import '../../../widgets/section_title.dart';

class NearbyList extends StatelessWidget {
  const NearbyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Próximos de você',
          actionText: 'Ver mapa',
          onActionTap: () {
            Navigator.pushNamed(context, AppRoutes.fullMap);
          },
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              PlaceCard(
                title: 'Praça dos Três Poderes',
                category: 'Histórico',
                distance: '650 m',
                rating: 4.7,
                icon: Icons.flag,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.placeDetails);
                },
              ),
              PlaceCard(
                title: 'Esplanada dos Ministérios',
                category: 'Arquitetura',
                distance: '1,0 km',
                rating: 4.6,
                icon: Icons.account_balance,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.placeDetails);
                },
              ),
              PlaceCard(
                title: 'Biblioteca Nacional',
                category: 'Cultura',
                distance: '1,4 km',
                rating: 4.5,
                icon: Icons.local_library,
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