import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../utils/app_colors.dart';

class FullMapPage extends StatelessWidget {
  const FullMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Turistei'),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(-15.793889, -47.882778),
          initialZoom: 13,
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
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_pin,
                  color: AppColors.primary,
                  size: 42,
                ),
              ),
              Marker(
                point: const LatLng(-15.7801, -47.9292),
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_pin,
                  color: AppColors.secondary,
                  size: 42,
                ),
              ),
              Marker(
                point: const LatLng(-15.7890, -47.8825),
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_pin,
                  color: AppColors.tertiary,
                  size: 42,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}