import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_radius.dart';
import '../utils/app_spacing.dart';

class PlaceCard extends StatelessWidget {
  final String title;
  final String category;
  final String distance;
  final double rating;
  final IconData icon;
  final VoidCallback? onTap;

  const PlaceCard({
    super.key,
    required this.title,
    required this.category,
    required this.distance,
    required this.rating,
    this.icon = Icons.place,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.large),
      onTap: onTap,
      child: Container(
        width: 230,
        margin: const EdgeInsets.only(right: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.large),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              category,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.accent,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(rating.toString()),
                const Spacer(),
                Text(distance),
              ],
            ),
          ],
        ),
      ),
    );
  }
}