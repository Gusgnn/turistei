import 'package:flutter/material.dart';

import '../../../models/event.dart';
import '../../../routers/app_routes.dart';
import '../../../services/event_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/event_card.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/section_title.dart';

class EventCarousel extends StatefulWidget {
  const EventCarousel({super.key});

  @override
  State<EventCarousel> createState() => _EventCarouselState();
}

class _EventCarouselState extends State<EventCarousel> {
  final EventService _eventService = EventService();

  Future<List<Event>>? _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = _eventService.getEvents();
  }

  void _openEvent(Event event) {
    Navigator.pushNamed(
      context,
      AppRoutes.eventDetails,
      arguments: event.id,
    );
  }

  String _formatDate(Event event) {
  if (event.date.isEmpty) return 'Data não informada';

  final parsedDate = DateTime.tryParse(event.date);

  if (parsedDate == null) {
    return event.time.isEmpty ? event.date : '${event.date} às ${event.time}';
  }

  final day = parsedDate.day.toString().padLeft(2, '0');
  final month = parsedDate.month.toString().padLeft(2, '0');
  final year = parsedDate.year.toString();

  final formattedDate = '$day/$month/$year';

  if (event.time.isEmpty) {
    return formattedDate;
  }

  return '$formattedDate às ${event.time}';
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: _eventsFuture,
      builder: (context, snapshot) {
        if (_eventsFuture == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget(
            message: 'Carregando eventos...',
          );
        }

        if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Eventos em Brasília'),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ],
          );
        }

        final events = snapshot.data ?? [];

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
            if (events.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('Nenhum evento encontrado.'),
                ),
              )
            else
              SizedBox(
                height: 135,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];

                    return EventCard(
                      title: event.title,
                      date: _formatDate(event),
                      location: event.location.isEmpty
                          ? 'Local não informado'
                          : event.location,
                      onTap: () => _openEvent(event),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}