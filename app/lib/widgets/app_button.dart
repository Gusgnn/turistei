import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_radius.dart';
import '../utils/app_spacing.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool outlined;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: outlined
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
              label: Text(text),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                ),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
              label: Text(text),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
              ),
            ),
    );
  }
}