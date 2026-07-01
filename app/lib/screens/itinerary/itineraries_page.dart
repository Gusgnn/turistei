import 'package:flutter/material.dart';

import '../../models/itinerary.dart';
import '../../routers/app_routes.dart';
import '../../services/itinerary_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/loading_widget.dart';

class ItinerariesPage extends StatefulWidget {
  const ItinerariesPage({super.key});

  @override
  State<ItinerariesPage> createState() => _ItinerariesPageState();
}

class _ItinerariesPageState extends State<ItinerariesPage> {
  final ItineraryService _itineraryService = ItineraryService();

  Future<List<Itinerary>>? _itinerariesFuture;

  @override
  void initState() {
    super.initState();
    _loadItineraries();
  }

  void _loadItineraries() {
    _itinerariesFuture = _itineraryService.getMyItineraries();
  }

  Future<void> _openCreate() async {
    await Navigator.pushNamed(context, AppRoutes.createItinerary);

    setState(() {
      _loadItineraries();
    });
  }

  void _openDetails(Itinerary itinerary) {
    Navigator.pushNamed(
      context,
      AppRoutes.itineraryDetails,
      arguments: itinerary.id,
    );
  }

  Future<void> _deleteItinerary(Itinerary itinerary) async {
    try {
      await _itineraryService.deleteItinerary(itinerary.id);

      setState(() {
        _loadItineraries();
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Roteiro removido.')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover roteiro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus roteiros'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _openCreate,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<Itinerary>>(
        future: _itinerariesFuture,
        builder: (context, snapshot) {
          if (_itinerariesFuture == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(message: 'Carregando roteiros...');
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'Erro ao carregar roteiros: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final itineraries = snapshot.data ?? [];

          if (itineraries.isEmpty) {
            return const Center(
              child: Text(
                'Você ainda não possui roteiros.',
                style: AppTextStyles.small,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: itineraries.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final itinerary = itineraries[index];

              return Dismissible(
                key: ValueKey(itinerary.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => _deleteItinerary(itinerary),
                child: ListTile(
                  leading: const Icon(
                    Icons.map_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(itinerary.name),
                  subtitle: Text(
                    itinerary.description.isEmpty
                        ? 'Toque para ver os detalhes'
                        : itinerary.description,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _openDetails(itinerary),
                ),
              );
            },
          );
        },
      ),
    );
  }
}