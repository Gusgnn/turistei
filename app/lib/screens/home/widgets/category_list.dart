import 'package:flutter/material.dart';

import '../../../models/category.dart';
import '../../../routers/app_routes.dart';
import '../../../services/category_service.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final CategoryService _categoryService = CategoryService();

  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _categoryService.getCategories();
  }

  IconData _getIcon(Category category) {
    final name = category.name.toLowerCase();

    if (name.contains('cultura')) return Icons.account_balance;
    if (name.contains('evento')) return Icons.event;
    if (name.contains('gastronomia') || name.contains('restaurante')) {
      return Icons.restaurant;
    }
    if (name.contains('natureza') || name.contains('parque')) {
      return Icons.park;
    }
    if (name.contains('compra') || name.contains('shopping')) {
      return Icons.shopping_bag;
    }
    if (name.contains('hotel')) return Icons.hotel;
    if (name.contains('hist')) return Icons.museum;

    return Icons.location_on;
  }

  Color _getColor(Category category) {
    final name = category.name.toLowerCase();

    if (name.contains('cultura')) return Colors.purple;
    if (name.contains('evento')) return Colors.orange;
    if (name.contains('gastronomia') || name.contains('restaurante')) {
      return Colors.green;
    }
    if (name.contains('natureza') || name.contains('parque')) {
      return Colors.teal;
    }
    if (name.contains('compra') || name.contains('shopping')) {
      return AppColors.primary;
    }
    if (name.contains('hotel')) return Colors.blue;
    if (name.contains('hist')) return Colors.brown;

    return AppColors.primary;
  }

  void _openCategoryPlaces(Category category) {
    Navigator.pushNamed(
      context,
      AppRoutes.categoryPlaces,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Text(
            'Erro ao carregar categorias',
            style: TextStyle(color: Colors.red),
          );
        }

        final categories = snapshot.data ?? [];

        if (categories.isEmpty) {
          return const Text(
            'Nenhuma categoria encontrada.',
            style: AppTextStyles.small,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categorias',
              style: AppTextStyles.subtitle,
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 92,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) {
                  return const SizedBox(width: AppSpacing.md);
                },
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final color = _getColor(category);

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _openCategoryPlaces(category),
                    child: Container(
                      width: 92,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: color.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getIcon(category),
                            color: color,
                            size: 28,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            category.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.small,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}