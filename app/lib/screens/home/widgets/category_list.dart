import 'package:flutter/material.dart';

import '../../../routers/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/category_card.dart';
import '../../../widgets/section_title.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Museus',
        'icon': Icons.museum,
        'color': AppColors.tertiary,
      },
      {
        'title': 'Parques',
        'icon': Icons.park,
        'color': AppColors.secondary,
      },
      {
        'title': 'Gastronomia',
        'icon': Icons.restaurant,
        'color': AppColors.primary,
      },
      {
        'title': 'Cultura',
        'icon': Icons.theater_comedy,
        'color': AppColors.tertiary,
      },
      {
        'title': 'Compras',
        'icon': Icons.shopping_bag,
        'color': AppColors.accent,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Categorias',
          actionText: 'Ver todas',
          onActionTap: () {
            Navigator.pushNamed(context, AppRoutes.categories);
          },
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 105,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              final category = categories[index];

              return CategoryCard(
                title: category['title'] as String,
                icon: category['icon'] as IconData,
                color: category['color'] as Color,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.categoryPlaces);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}