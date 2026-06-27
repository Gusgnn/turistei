import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../widgets/place_card.dart';
import '../../widgets/section_title.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SectionTitle(title: 'Seus locais favoritos'),

            SizedBox(height: AppSpacing.lg),

            PlaceCard(
              title: 'Catedral Metropolitana',
              category: 'Arquitetura',
              distance: '1,2 km',
              rating: 4.8,
              icon: Icons.account_balance,
            ),

            SizedBox(height: AppSpacing.md),

            PlaceCard(
              title: 'Parque da Cidade',
              category: 'Natureza',
              distance: '2,4 km',
              rating: 4.9,
              icon: Icons.park,
            ),
          ],
        ),
      ),
    );
  }
}