import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../routers/app_routes.dart';
import '../../services/profile_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/loading_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileService _profileService = ProfileService();

  Future<User>? _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.getProfile();
  }

  Future<void> _logout() async {
    await _profileService.logout();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: FutureBuilder<User>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (_profileFuture == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(
              message: 'Carregando perfil...',
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'Erro ao carregar perfil: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
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
                  user.name.isEmpty ? 'Usuário' : user.name,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  user.email.isEmpty ? 'E-mail não informado' : user.email,
                  style: AppTextStyles.small,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xl),

                _buildMenuItem(
                  icon: Icons.edit_outlined,
                  title: 'Editar perfil',
                  onTap: () {},
                ),

                _buildMenuItem(
                  icon: Icons.favorite_border,
                  title: 'Favoritos',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.favorites);
                  },
                ),

                _buildMenuItem(
                  icon: Icons.map_outlined,
                  title: 'Meus roteiros',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.itineraries);
                  },
                ),

                _buildMenuItem(
                  icon: Icons.settings_outlined,
                  title: 'Configurações',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.settings);
                  },
                ),

                _buildMenuItem(
                  icon: Icons.history,
                  title: 'Histórico',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.history);
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: AppColors.primary,
                  ),
                  title: const Text('Sair'),
                  onTap: _logout,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}