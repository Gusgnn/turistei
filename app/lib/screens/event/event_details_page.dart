import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Detalhes do evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.event,
              size: 72,
              color: AppColors.primary,
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              'Festival Cultural',
              style: AppTextStyles.title,
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              'Hoje • Parque da Cidade',
              style: AppTextStyles.subtitle,
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              'Evento cultural com música, gastronomia e atrações para toda a família.',
              style: AppTextStyles.body,
            ),

            const Spacer(),

            AppButton(
              text: 'Ver localização',
              icon: Icons.map_outlined,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}