import 'package:flutter/material.dart';

import '../../routers/app_routes.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final AuthService authService = AuthService();

  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      await authService.login(
        email: emailController.text.trim(),
        senha: senhaController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceAll('Exception: ', '')),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

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

              AppTextField(
                label: 'E-mail',
                icon: Icons.email_outlined,
                controller: emailController,
              ),

              const SizedBox(height: AppSpacing.md),

              AppTextField(
                label: 'Senha',
                icon: Icons.lock_outline,
                obscureText: true,
                controller: senhaController,
              ),

              const SizedBox(height: AppSpacing.lg),

              AppButton(
                text: isLoading ? 'Entrando...' : 'Entrar',
                onPressed: isLoading ? () {} : login,
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