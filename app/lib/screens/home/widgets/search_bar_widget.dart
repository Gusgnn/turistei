import 'package:flutter/material.dart';

import '../../../routers/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_radius.dart';
import '../../../utils/app_spacing.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.large),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.search);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.search,
              color: AppColors.primary,
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Pesquisar locais, eventos ou categorias...',
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}