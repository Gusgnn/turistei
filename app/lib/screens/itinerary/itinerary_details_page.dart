import 'package:flutter/material.dart';

import '../../models/itinerary.dart';
import '../../models/place.dart';
import '../../routers/app_routes.dart';
import '../../services/itinerary_service.dart';
import '../../services/place_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/loading_widget.dart';

class ItineraryDetailsPage extends StatefulWidget {
  const ItineraryDetailsPage({super.key});

  @override
  State<ItineraryDetailsPage> createState() => _ItineraryDetailsPageState();
}

class _ItineraryDetailsPageState extends State<ItineraryDetailsPage> {
  final ItineraryService _itineraryService = ItineraryService();
  final PlaceService _placeService = PlaceService();

  String? _itineraryId;
  Future<Itinerary>? _itineraryFuture;
  Future<List<Place>>? _placesFuture;

  List<Place> _places = [];
  bool _loadingAction = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_itineraryFuture != null) return;

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is String) {
      _itineraryId = args;
      _loadData(args);
    }
  }

  void _loadData(String itineraryId) {
    _itineraryFuture = _itineraryService.getItineraryById(itineraryId);
    _placesFuture = _loadPlaces(itineraryId);
  }

  Future<List<Place>> _loadPlaces(String itineraryId) async {
    final places = await _itineraryService.getPlacesByItinerary(itineraryId);
    _places = places;
    return places;
  }

  void _refreshPlaces() {
    if (_itineraryId == null) return;

    setState(() {
      _placesFuture = _loadPlaces(_itineraryId!);
    });
  }

  void _openPlace(Place place) {
    Navigator.pushNamed(
      context,
      AppRoutes.placeDetails,
      arguments: place.id,
    );
  }

  bool _alreadyInItinerary(Place place) {
    return _places.any((item) => item.id == place.id);
  }

  Future<void> _removePlace(Place place) async {
    if (_itineraryId == null) return;

    setState(() {
      _loadingAction = true;
    });

    try {
      await _itineraryService.removePlaceFromItinerary(
        itineraryId: _itineraryId!,
        placeId: place.id,
      );

      _refreshPlaces();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Local removido do roteiro.')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover local: $e')),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _loadingAction = false;
      });
    }
  }

  Future<void> _updateOrder(List<Place> reorderedPlaces) async {
    if (_itineraryId == null) return;

    setState(() {
      _loadingAction = true;
    });

    try {
      await _itineraryService.updatePlacesOrder(
        itineraryId: _itineraryId!,
        places: reorderedPlaces,
      );

      setState(() {
        _places = reorderedPlaces;
        _placesFuture = Future.value(_places);
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ordem atualizada.')),
      );
    } catch (e) {
      _refreshPlaces();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao alterar ordem: $e')),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _loadingAction = false;
      });
    }
  }

  Future<void> _movePlaceUp(int index) async {
    if (index <= 0) return;

    final reorderedPlaces = List<Place>.from(_places);
    final place = reorderedPlaces.removeAt(index);
    reorderedPlaces.insert(index - 1, place);

    await _updateOrder(reorderedPlaces);
  }

  Future<void> _movePlaceDown(int index) async {
    if (index >= _places.length - 1) return;

    final reorderedPlaces = List<Place>.from(_places);
    final place = reorderedPlaces.removeAt(index);
    reorderedPlaces.insert(index + 1, place);

    await _updateOrder(reorderedPlaces);
  }

  Future<void> _openAddPlaceDialog() async {
    if (_itineraryId == null) return;

    final allPlaces = await _placeService.getPlaces();

    if (!mounted) return;

    final availablePlaces = allPlaces
        .where((place) => !_alreadyInItinerary(place))
        .toList();

    if (availablePlaces.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não há novos locais para adicionar.')),
      );
      return;
    }

    final selectedPlace = await showDialog<Place>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar local'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: availablePlaces.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final place = availablePlaces[index];

                return ListTile(
                  leading: const Icon(
                    Icons.add_location_alt_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(place.title),
                  subtitle: Text(
                    place.category.isEmpty ? 'Sem categoria' : place.category,
                  ),
                  onTap: () => Navigator.pop(context, place),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );

    if (selectedPlace == null) return;

    setState(() {
      _loadingAction = true;
    });

    try {
      await _itineraryService.addPlaceToItinerary(
        itineraryId: _itineraryId!,
        placeId: selectedPlace.id,
        order: _places.length + 1,
      );

      _refreshPlaces();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Local adicionado ao roteiro.')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar local: $e')),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _loadingAction = false;
      });
    }
  }

  Widget _buildPlacesList() {
    return FutureBuilder<List<Place>>(
      future: _placesFuture,
      builder: (context, placesSnapshot) {
        if (placesSnapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget(
            message: 'Carregando locais...',
          );
        }

        if (placesSnapshot.hasError) {
          return Text(
            'Erro ao carregar locais: ${placesSnapshot.error}',
            style: const TextStyle(color: Colors.red),
          );
        }

        final places = placesSnapshot.data ?? [];
        _places = places;

        if (places.isEmpty) {
          return const Center(
            child: Text(
              'Este roteiro ainda não possui locais.',
              style: AppTextStyles.small,
            ),
          );
        }

        return ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];

            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(place.title),
                subtitle: Text(
                  place.category.isEmpty ? 'Sem categoria' : place.category,
                ),
                onTap: () => _openPlace(place),
                trailing: Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_up),
                      onPressed: _loadingAction || index == 0
                          ? null
                          : () => _movePlaceUp(index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onPressed:
                          _loadingAction || index == places.length - 1
                              ? null
                              : () => _movePlaceDown(index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed:
                          _loadingAction ? null : () => _removePlace(place),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_itineraryId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes do roteiro')),
        body: const Center(child: Text('Roteiro não informado.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do roteiro'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_location_alt_outlined),
            onPressed: _loadingAction ? null : _openAddPlaceDialog,
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: FutureBuilder<Itinerary>(
        future: _itineraryFuture,
        builder: (context, itinerarySnapshot) {
          if (itinerarySnapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(message: 'Carregando roteiro...');
          }

          if (itinerarySnapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'Erro ao carregar roteiro: ${itinerarySnapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final itinerary = itinerarySnapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itinerary.name, style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  itinerary.description.isEmpty
                      ? 'Sem descrição cadastrada.'
                      : itinerary.description,
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  text: 'Adicionar local',
                  icon: Icons.add_location_alt_outlined,
                  onPressed: _loadingAction ? null : _openAddPlaceDialog,
                ),
                const SizedBox(height: AppSpacing.lg),
                Expanded(
                  child: _buildPlacesList(),
                ),
                AppButton(
                  text: 'Iniciar roteiro',
                  icon: Icons.navigation_outlined,
                  onPressed: _places.isEmpty ? null : () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}