import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../services/category_service.dart';

import '../../routers/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import 'widgets/home_header.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/category_list.dart';
import 'widgets/event_carousel.dart';
import 'widgets/recommendation_list.dart';
import 'widgets/popular_list.dart';
import 'widgets/nearby_list.dart';
import 'widgets/mini_map.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onBottomNavTap(BuildContext context, int index) {
    if (index == 0) return;

    if (index == 1) {
      Navigator.pushNamed(context, AppRoutes.favorites);
    }

    if (index == 2) {
      Navigator.pushNamed(context, AppRoutes.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(),

              SizedBox(height: AppSpacing.lg),

              SearchBarWidget(),

              SizedBox(height: AppSpacing.lg),

              CategoryList(),

              SizedBox(height: AppSpacing.xl),

              EventCarousel(),

              SizedBox(height: AppSpacing.xl),

              RecommendationList(),

              SizedBox(height: AppSpacing.xl),

              PopularList(),

              SizedBox(height: AppSpacing.xl),

              NearbyList(),

              SizedBox(height: AppSpacing.xl),

              MiniMap(),

              SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        currentIndex: 0,
        onTap: (index) => _onBottomNavTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}