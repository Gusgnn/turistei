import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../widgets/category_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Museus', 'icon': Icons.museum, 'color': AppColors.tertiary},
      {'title': 'Parques', 'icon': Icons.park, 'color': AppColors.secondary},
      {'title': 'Gastronomia', 'icon': Icons.restaurant, 'color': AppColors.primary},
      {'title': 'Cultura', 'icon': Icons.theater_comedy, 'color': AppColors.tertiary},
      {'title': 'Compras', 'icon': Icons.shopping_bag, 'color': AppColors.accent},
      {'title': 'Eventos', 'icon': Icons.event, 'color': AppColors.primary},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final item = categories[index];

            return CategoryCard(
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              color: item['color'] as Color,
              onTap: () {
                Navigator.pushNamed(context, '/category-places');
              },
            );
          },
        ),
      ),
    );
  }
}