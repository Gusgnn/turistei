import 'package:flutter/material.dart';

import '../../routers/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';

class ItinerariesPage extends StatelessWidget {
  const ItinerariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus roteiros')),
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createItinerary);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          ListTile(
            leading: const Icon(Icons.map_outlined, color: AppColors.primary),
            title: const Text('Roteiro de um dia em Brasília'),
            subtitle: const Text('4 locais • Catedral, Congresso, Museu e Pontão'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.itineraryDetails);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.park, color: AppColors.secondary),
            title: const Text('Roteiro natureza'),
            subtitle: const Text('3 locais • Parques e áreas verdes'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.itineraryDetails);
            },
          ),
        ],
      ),
    );
  }
}