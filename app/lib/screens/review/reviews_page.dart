import 'package:flutter/material.dart';

import '../../routers/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        'name': 'Ana',
        'rating': '5.0',
        'text': 'Lugar muito bonito e ótimo para tirar fotos.',
      },
      {
        'name': 'Carlos',
        'rating': '4.5',
        'text': 'Boa experiência, mas estava bem cheio.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Avaliações')),
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addReview);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: reviews.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final review = reviews[index];

          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review['name']!, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.accent, size: 18),
                    const SizedBox(width: 4),
                    Text(review['rating']!),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(review['text']!),
              ],
            ),
          );
        },
      ),
    );
  }
}