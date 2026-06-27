import 'package:flutter/material.dart';

import '../../routers/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: 48),

              Image.asset(
                'assets/images/logo.png',
                height: 110,
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                AppConstants.appName,
                style: AppTextStyles.title.copyWith(
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Explore os melhores destinos da capital.',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: 42),

              const AppTextField(
                label: 'E-mail',
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: AppSpacing.md),

              const AppTextField(
                label: 'Senha',
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: AppSpacing.lg),

              AppButton(
                text: 'Entrar',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: Text(
                      'ou',
                      style: AppTextStyles.small,
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                child: const Text('Criar conta'),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                child: const Text('Continuar como visitante'),
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'Versão 1.0',
                style: AppTextStyles.small,
              ),
            ],
          ),
        ),
      ),
    );
  }
}