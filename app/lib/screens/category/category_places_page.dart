import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../widgets/place_card.dart';

class CategoryPlacesPage extends StatelessWidget {
  const CategoryPlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locais da categoria')),
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: const [
          PlaceCard(
            title: 'Museu Nacional',
            category: 'Cultura',
            distance: '900 m',
            rating: 4.7,
            icon: Icons.museum,
          ),
          SizedBox(height: AppSpacing.md),
          PlaceCard(
            title: 'Catedral Metropolitana',
            category: 'Arquitetura',
            distance: '1,2 km',
            rating: 4.8,
            icon: Icons.account_balance,
          ),
          SizedBox(height: AppSpacing.md),
          PlaceCard(
            title: 'Congresso Nacional',
            category: 'Monumento',
            distance: '800 m',
            rating: 4.9,
            icon: Icons.location_city,
          ),
        ],
      ),
    );
  }
}