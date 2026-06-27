import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';

class AddReviewPage extends StatelessWidget {
  const AddReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar avaliação')),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sua nota', style: AppTextStyles.subtitle),
            const SizedBox(height: AppSpacing.md),

            const Row(
              children: [
                Icon(Icons.star, color: AppColors.accent, size: 36),
                Icon(Icons.star, color: AppColors.accent, size: 36),
                Icon(Icons.star, color: AppColors.accent, size: 36),
                Icon(Icons.star, color: AppColors.accent, size: 36),
                Icon(Icons.star_border, color: AppColors.accent, size: 36),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Comentário',
                alignLabelWithHint: true,
              ),
            ),

            const Spacer(),

            AppButton(
              text: 'Enviar avaliação',
              icon: Icons.send_outlined,
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