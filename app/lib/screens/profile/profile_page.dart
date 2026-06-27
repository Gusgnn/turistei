import 'package:flutter/material.dart';

import '../../routers/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 48,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            Text(
              'Gustavo',
              style: AppTextStyles.title.copyWith(
                color: AppColors.textPrimary,
              ),
            ),

            Text(
              'gustavo@email.com',
              style: AppTextStyles.small,
            ),

            const SizedBox(height: AppSpacing.xl),

            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Editar perfil'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.profile);
              },
            ),

            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favoritos'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.favorites);
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Configurações'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.primary),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Histórico'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.history);
              },
            ),
          ],
        ),
      ),
    );
  }
}