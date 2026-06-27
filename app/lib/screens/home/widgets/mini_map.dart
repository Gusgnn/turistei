import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../routers/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_radius.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/section_title.dart';

class MiniMap extends StatelessWidget {
  const MiniMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Explore no mapa',
          actionText: 'Expandir',
          onActionTap: () {
            Navigator.pushNamed(context, AppRoutes.fullMap);
          },
        ),

        const SizedBox(height: AppSpacing.md),

        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.large),
          child: SizedBox(
            height: 220,
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(-15.793889, -47.882778),
                initialZoom: 12.5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.turistei',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: const LatLng(-15.7997, -47.8645),
                      width: 45,
                      height: 45,
                      child: const Icon(
                        Icons.location_pin,
                        color: AppColors.primary,
                        size: 38,
                      ),
                    ),
                    Marker(
                      point: const LatLng(-15.7801, -47.9292),
                      width: 45,
                      height: 45,
                      child: const Icon(
                        Icons.location_pin,
                        color: AppColors.secondary,
                        size: 38,
                      ),
                    ),
                    Marker(
                      point: const LatLng(-15.7890, -47.8825),
                      width: 45,
                      height: 45,
                      child: const Icon(
                        Icons.location_pin,
                        color: AppColors.tertiary,
                        size: 38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}