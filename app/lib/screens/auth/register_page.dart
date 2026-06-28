import 'package:flutter/material.dart';

import '../../routers/app_routes.dart';
import '../../services/auth_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  final AuthService authService = AuthService();

  bool isLoading = false;

  Future<void> register() async {
    if (senhaController.text.trim() != confirmarSenhaController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem.'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await authService.register(
        nome: nomeController.text.trim(),
        email: emailController.text.trim(),
        senha: senhaController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.onboarding,
      );
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
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
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

              AppTextField(
                label: 'Nome completo',
                icon: Icons.person_outline,
                controller: nomeController,
              ),

              const SizedBox(height: AppSpacing.md),

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

              const SizedBox(height: AppSpacing.md),

              AppTextField(
                label: 'Confirmar senha',
                icon: Icons.lock_reset_outlined,
                obscureText: true,
                controller: confirmarSenhaController,
              ),

              const SizedBox(height: AppSpacing.lg),

              AppButton(
                text: isLoading ? 'Criando...' : 'Criar conta',
                onPressed: isLoading ? () {} : register,
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