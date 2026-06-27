import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class CreateItineraryPage extends StatelessWidget {
  const CreateItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar roteiro')),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const AppTextField(
              label: 'Nome do roteiro',
              icon: Icons.map_outlined,
            ),

            const SizedBox(height: AppSpacing.lg),

            const ListTile(
              leading: Icon(Icons.add_location_alt_outlined),
              title: Text('Adicionar local'),
              subtitle: Text('Escolha locais para montar seu roteiro'),
            ),

            const ListTile(
              leading: Icon(Icons.schedule_outlined),
              title: Text('Tempo disponível'),
              subtitle: Text('Meio período, um dia ou fim de semana'),
            ),

            const Spacer(),

            AppButton(
              text: 'Salvar roteiro',
              icon: Icons.save_outlined,
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