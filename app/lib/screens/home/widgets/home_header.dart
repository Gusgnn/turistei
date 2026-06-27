import 'package:flutter/material.dart';

import '../../../routers/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, Gustavo',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Explore os melhores destinos da capital.',
                style: AppTextStyles.small,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.notifications);
          },
          icon: const Icon(Icons.notifications_none),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.settings);
          },
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }
}