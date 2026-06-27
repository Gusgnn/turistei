import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
                height: 100,
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                'Recuperar senha',
                style: AppTextStyles.title.copyWith(
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Informe seu e-mail para receber as instruções de recuperação.',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: AppSpacing.xl),

              const AppTextField(
                label: 'E-mail',
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: AppSpacing.lg),

              AppButton(
                text: 'Enviar instruções',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Funcionalidade disponível em breve.'),
                    ),
                  );
                },
              ),

              const SizedBox(height: AppSpacing.md),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Voltar para login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}