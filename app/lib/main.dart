import 'package:flutter/material.dart';

import 'routers/app_routes.dart';
import 'utils/app_constants.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const TuristeiApp());
}

class TuristeiApp extends StatelessWidget {
  const TuristeiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: AppConstants.appName,

      theme: AppTheme.lightTheme,

      initialRoute: AppRoutes.login,

      routes: AppRoutes.routes,
    );
  }
}