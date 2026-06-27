import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';

class PlaceDetailsPage extends StatelessWidget {
  const PlaceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Detalhes do local'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.account_balance,
                size: 72,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              'Catedral Metropolitana',
              style: AppTextStyles.title,
            ),

            const SizedBox(height: AppSpacing.sm),

            Row(
              children: const [
                Icon(Icons.star, color: AppColors.accent),
                SizedBox(width: 4),
                Text('4.8'),
                SizedBox(width: 16),
                Icon(Icons.place_outlined),
                SizedBox(width: 4),
                Text('1,2 km'),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              'Um dos principais cartões-postais de Brasília, conhecido por sua arquitetura moderna e formato marcante.',
              style: AppTextStyles.body,
            ),

            const SizedBox(height: AppSpacing.xl),

            AppButton(
              text: 'Adicionar aos favoritos',
              icon: Icons.favorite_border,
              onPressed: () {},
            ),

            const SizedBox(height: AppSpacing.md),

            AppButton(
              text: 'Ver no mapa',
              icon: Icons.map_outlined,
              outlined: true,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}