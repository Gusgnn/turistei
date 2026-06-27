import 'package:flutter/material.dart';

import '../../routers/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: 32),

              Image.asset(
                'assets/images/logo.png',
                height: 95,
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                'Criar conta',
                style: AppTextStyles.title.copyWith(
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Comece sua jornada pelo Turistei.',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: 36),

              const AppTextField(
                label: 'Nome completo',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: AppSpacing.md),

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

              const SizedBox(height: AppSpacing.md),

              const AppTextField(
                label: 'Confirmar senha',
                icon: Icons.lock_reset_outlined,
                obscureText: true,
              ),

              const SizedBox(height: AppSpacing.lg),

              AppButton(
                text: 'Criar conta',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.onboarding,
                  );
                },
              ),

              const SizedBox(height: AppSpacing.md),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Já possui conta? Entrar'),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                child: const Text('Continuar como visitante'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}