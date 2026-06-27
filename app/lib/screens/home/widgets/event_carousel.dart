import 'package:flutter/material.dart';

import '../../../routers/app_routes.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/event_card.dart';
import '../../../widgets/section_title.dart';

class EventCarousel extends StatelessWidget {
  const EventCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Eventos em Brasília',
          actionText: 'Ver todos',
          onActionTap: () {
            Navigator.pushNamed(context, AppRoutes.eventDetails);
          },
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 105,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              EventCard(
                title: 'Festival Cultural',
                date: 'Hoje',
                location: 'Parque da Cidade',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.eventDetails);
                },
              ),
              EventCard(
                title: 'Feira da Torre',
                date: 'Sábado',
                location: 'Torre de TV',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.eventDetails);
                },
              ),
              EventCard(
                title: 'Exposição de Arte',
                date: 'Domingo',
                location: 'Museu Nacional',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.eventDetails);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}