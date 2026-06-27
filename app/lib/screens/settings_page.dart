import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      backgroundColor: AppColors.background,
      body: ListView(
        children: const [
          SwitchListTile(
            value: true,
            onChanged: null,
            title: Text('Notificações'),
            subtitle: Text('Receber novidades e recomendações'),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Idioma'),
            subtitle: Text('Português'),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Sobre o Turistei'),
            subtitle: Text('Versão 1.0'),
          ),
        ],
      ),
    );
  }
}