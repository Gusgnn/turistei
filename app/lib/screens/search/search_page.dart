import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../widgets/place_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar')),
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: const [
          TextField(
            decoration: InputDecoration(
              labelText: 'Pesquisar locais...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
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
    );
  }
}