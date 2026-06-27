import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_radius.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Novo evento em Brasília',
        'message': 'Festival Cultural acontece hoje no Parque da Cidade.',
        'time': 'Hoje',
        'icon': Icons.event,
        'color': AppColors.primary,
      },
      {
        'title': 'Recomendação para você',
        'message': 'A Catedral Metropolitana combina com seus interesses.',
        'time': 'Agora',
        'icon': Icons.auto_awesome,
        'color': AppColors.accent,
      },
      {
        'title': 'Lugar próximo',
        'message': 'O Museu Nacional está a menos de 1 km de você.',
        'time': '10 min atrás',
        'icon': Icons.place_outlined,
        'color': AppColors.tertiary,
      },
      {
        'title': 'Roteiro sugerido',
        'message': 'Criamos uma sugestão de roteiro cultural para hoje.',
        'time': 'Ontem',
        'icon': Icons.map_outlined,
        'color': AppColors.secondary,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: notifications.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.large),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        item['message'] as String,
                        style: AppTextStyles.small,
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        item['time'] as String,
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}