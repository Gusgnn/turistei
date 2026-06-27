import 'package:flutter/material.dart';

import '../../routers/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_radius.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final historyItems = [
      {
        'title': 'Catedral Metropolitana',
        'category': 'Arquitetura',
        'date': 'Visitado hoje',
        'icon': Icons.account_balance,
        'color': AppColors.primary,
      },
      {
        'title': 'Museu Nacional',
        'category': 'Cultura',
        'date': 'Visitado ontem',
        'icon': Icons.museum,
        'color': AppColors.tertiary,
      },
      {
        'title': 'Parque da Cidade',
        'category': 'Natureza',
        'date': 'Visitado há 3 dias',
        'icon': Icons.park,
        'color': AppColors.secondary,
      },
      {
        'title': 'Torre de TV',
        'category': 'Turismo',
        'date': 'Visitado semana passada',
        'icon': Icons.tour,
        'color': AppColors.accent,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: historyItems.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final item = historyItems[index];

          return InkWell(
            borderRadius: BorderRadius.circular(AppRadius.large),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.placeDetails);
            },
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.large),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: item['color'] as Color,
                    child: Icon(
                      item['icon'] as IconData,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: AppSpacing.md),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'] as String,
                          style: AppTextStyles.body.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xs),

                        Text(
                          item['category'] as String,
                          style: AppTextStyles.small,
                        ),

                        const SizedBox(height: AppSpacing.xs),

                        Text(
                          item['date'] as String,
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}