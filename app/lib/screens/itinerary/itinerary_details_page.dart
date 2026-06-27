import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';

class ItineraryDetailsPage extends StatelessWidget {
  const ItineraryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final places = [
      'Catedral Metropolitana',
      'Congresso Nacional',
      'Museu Nacional',
      'Pontão do Lago Sul',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do roteiro')),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Roteiro de um dia em Brasília', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.sm),
            Text('4 locais recomendados', style: AppTextStyles.subtitle),
            const SizedBox(height: AppSpacing.lg),

            Expanded(
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(places[index]),
                    subtitle: const Text('Tempo estimado: 1h'),
                  );
                },
              ),
            ),

            AppButton(
              text: 'Iniciar roteiro',
              icon: Icons.navigation_outlined,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}