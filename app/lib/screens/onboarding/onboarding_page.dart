import 'package:flutter/material.dart';

import '../../routers/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_radius.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentStep = 0;

  final List<String> selectedInterests = [];
  final List<String> selectedPreferences = [];

  final List<Map<String, dynamic>> interests = [
    {'title': 'Museus', 'icon': Icons.museum, 'color': AppColors.tertiary},
    {'title': 'Parques', 'icon': Icons.park, 'color': AppColors.secondary},
    {'title': 'Gastronomia', 'icon': Icons.restaurant, 'color': AppColors.primary},
    {'title': 'Cultura', 'icon': Icons.theater_comedy, 'color': AppColors.tertiary},
    {'title': 'Compras', 'icon': Icons.shopping_bag, 'color': AppColors.accent},
    {'title': 'Eventos', 'icon': Icons.event, 'color': AppColors.primary},
    {'title': 'Fotografia', 'icon': Icons.photo_camera, 'color': AppColors.secondary},
    {'title': 'Arquitetura', 'icon': Icons.account_balance, 'color': AppColors.tertiary},
  ];

  final List<Map<String, dynamic>> preferences = [
    {'title': 'Passeios rápidos', 'icon': Icons.timer_outlined},
    {'title': 'Roteiros completos', 'icon': Icons.map_outlined},
    {'title': 'Lugares famosos', 'icon': Icons.star_outline},
    {'title': 'Lugares tranquilos', 'icon': Icons.spa_outlined},
    {'title': 'Locais gratuitos', 'icon': Icons.money_off_outlined},
    {'title': 'Experiências em família', 'icon': Icons.family_restroom},
  ];

  void nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void toggleInterest(String title) {
    setState(() {
      selectedInterests.contains(title)
          ? selectedInterests.remove(title)
          : selectedInterests.add(title);
    });
  }

  void togglePreference(String title) {
    setState(() {
      selectedPreferences.contains(title)
          ? selectedPreferences.remove(title)
          : selectedPreferences.add(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: previousStep,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (currentStep + 1) / 3,
                      color: AppColors.primary,
                      backgroundColor: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.large),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    '${currentStep + 1}/3',
                    style: AppTextStyles.small,
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildStep(),
                ),
              ),

              AppButton(
                text: currentStep == 2 ? 'Finalizar' : 'Continuar',
                onPressed: nextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (currentStep) {
      case 0:
        return _welcomeStep();
      case 1:
        return _interestsStep();
      case 2:
        return _preferencesStep();
      default:
        return _welcomeStep();
    }
  }

  Widget _welcomeStep() {
    return Column(
      key: const ValueKey('welcome'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 110,
        ),

        const SizedBox(height: AppSpacing.xl),

        Text(
          'Bem-vindo ao Turistei!',
          textAlign: TextAlign.center,
          style: AppTextStyles.title.copyWith(
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        Text(
          'Agora vamos personalizar sua experiência para recomendar os melhores destinos de Brasília.',
          textAlign: TextAlign.center,
          style: AppTextStyles.subtitle,
        ),

        const SizedBox(height: AppSpacing.xl),

        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.large),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: AppColors.accent,
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Isso leva menos de um minuto.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _interestsStep() {
    return Column(
      key: const ValueKey('interests'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'O que você gosta de visitar?',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        Text(
          'Escolha seus interesses favoritos.',
          style: AppTextStyles.subtitle,
        ),

        const SizedBox(height: AppSpacing.lg),

        Expanded(
          child: GridView.builder(
            itemCount: interests.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.25,
            ),
            itemBuilder: (context, index) {
              final item = interests[index];
              final isSelected = selectedInterests.contains(item['title']);

              return _selectableCard(
                title: item['title'],
                icon: item['icon'],
                color: item['color'],
                selected: isSelected,
                onTap: () => toggleInterest(item['title']),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _preferencesStep() {
    return Column(
      key: const ValueKey('preferences'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Como você prefere explorar?',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        Text(
          'Essas escolhas ajudam a montar recomendações melhores.',
          style: AppTextStyles.subtitle,
        ),

        const SizedBox(height: AppSpacing.lg),

        Expanded(
          child: GridView.builder(
            itemCount: preferences.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.35,
            ),
            itemBuilder: (context, index) {
              final item = preferences[index];
              final isSelected = selectedPreferences.contains(item['title']);

              return _selectableCard(
                title: item['title'],
                icon: item['icon'],
                color: AppColors.primary,
                selected: isSelected,
                onTap: () => togglePreference(item['title']),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _selectableCard({
    required String title,
    required IconData icon,
    required Color color,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.large),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(
            color: selected ? color : const Color(0xFFE5E7EB),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : color,
              size: 34,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}