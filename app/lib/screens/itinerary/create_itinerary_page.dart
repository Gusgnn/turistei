import 'package:flutter/material.dart';

import '../../models/place.dart';
import '../../services/itinerary_service.dart';
import '../../services/place_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/loading_widget.dart';

class CreateItineraryPage extends StatefulWidget {
  const CreateItineraryPage({super.key});

  @override
  State<CreateItineraryPage> createState() => _CreateItineraryPageState();
}

class _CreateItineraryPageState extends State<CreateItineraryPage> {
  final ItineraryService _itineraryService = ItineraryService();
  final PlaceService _placeService = PlaceService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  Future<List<Place>>? _placesFuture;

  final List<Place> _selectedPlaces = [];
  final Map<String, TimeOfDay> _placeTimes = {};

  DateTime _selectedDate = DateTime.now();

  bool _loading = false;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _placesFuture = _placeService.getPlaces();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }

  String _formatWeekDay(DateTime date) {
    const days = [
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado',
      'Domingo',
    ];

    return days[date.weekday - 1];
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  int _timeToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  bool _isSelected(Place place) {
    return _selectedPlaces.any((selected) => selected.id == place.id);
  }

  List<Place> get _orderedSelectedPlaces {
    final places = List<Place>.from(_selectedPlaces);

    places.sort((a, b) {
      final timeA = _placeTimes[a.id];
      final timeB = _placeTimes[b.id];

      if (timeA == null && timeB == null) return 0;
      if (timeA == null) return 1;
      if (timeB == null) return -1;

      return _timeToMinutes(timeA).compareTo(_timeToMinutes(timeB));
    });

    return places;
  }

  void _togglePlace(Place place) {
    setState(() {
      if (_isSelected(place)) {
        _selectedPlaces.removeWhere((selected) => selected.id == place.id);
        _placeTimes.remove(place.id);
      } else {
        _selectedPlaces.add(place);
      }
    });
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date == null) return;

    setState(() {
      _selectedDate = date;
    });
  }

  Future<void> _pickTime(Place place) async {
    final currentTime = _placeTimes[place.id] ?? TimeOfDay.now();

    final time = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (time == null) return;

    setState(() {
      _placeTimes[place.id] = time;
    });
  }

  Future<void> _saveItinerary() async {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite o nome do roteiro.')),
      );
      return;
    }

    if (_selectedPlaces.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escolha pelo menos um local.')),
      );
      return;
    }

    final hasPlaceWithoutTime = _selectedPlaces.any(
      (place) => !_placeTimes.containsKey(place.id),
    );

    if (hasPlaceWithoutTime) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Defina um horário para todos os locais.'),
        ),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final formattedDescription = description.isEmpty
          ? 'Roteiro para ${_formatDate(_selectedDate)}'
          : '$description\nData do roteiro: ${_formatDate(_selectedDate)}';

      await _itineraryService.createItineraryWithPlaces(
        name: name,
        description: formattedDescription,
        places: _orderedSelectedPlaces,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Roteiro criado com sucesso.')),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar roteiro: $e')),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildPlaceImage(Place place, {bool selected = false}) {
    if (place.imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          place.imageUrl,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return _buildPlacePlaceholder(selected);
          },
        ),
      );
    }

    return _buildPlacePlaceholder(selected);
  }

  Widget _buildPlacePlaceholder(bool selected) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary
            : AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        selected ? Icons.check : Icons.add_location_alt_outlined,
        color: selected ? Colors.white : AppColors.primary,
      ),
    );
  }

  Widget _buildHeaderFields() {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Nome do roteiro',
            prefixIcon: const Icon(Icons.map_outlined),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Descrição opcional',
            prefixIcon: const Icon(Icons.description_outlined),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.primary,
            ),
            title: Text(_formatDate(_selectedDate)),
            subtitle: Text(_formatWeekDay(_selectedDate)),
            trailing: const Icon(Icons.chevron_right),
            onTap: _pickDate,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleCard() {
    final orderedPlaces = _orderedSelectedPlaces;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Agenda do roteiro',
                    style: AppTextStyles.subtitle,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${orderedPlaces.length} locais',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Toque no relógio para definir o horário',
              style: AppTextStyles.small,
            ),
            const SizedBox(height: AppSpacing.md),
            if (orderedPlaces.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Center(
                  child: Text(
                    'Adicione locais para montar sua programação.',
                    style: AppTextStyles.small,
                  ),
                ),
              )
            else
              Column(
                children: List.generate(orderedPlaces.length, (index) {
                  final place = orderedPlaces[index];
                  final time = _placeTimes[place.id];

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 72,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                time == null ? '--:--' : _formatTime(time),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (index != orderedPlaces.length - 1)
                              Container(
                                width: 2,
                                height: 76,
                                color: AppColors.primary,
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.md),
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: _buildPlaceImage(place, selected: true),
                            title: Text(
                              place.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              place.category.isEmpty
                                  ? 'Sem categoria'
                                  : place.category,
                            ),
                            trailing: Wrap(
                              spacing: 2,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.access_time),
                                  color: AppColors.primary,
                                  onPressed: () => _pickTime(place),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  color: Colors.red,
                                  onPressed: () => _togglePlace(place),
                                ),
                              ],
                            ),
                            onTap: () => _pickTime(place),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'Adicione locais pela lista abaixo',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlacesCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Locais disponíveis', style: AppTextStyles.subtitle),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar locais...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _search = value.trim().toLowerCase();
                });
              },
            ),
            const SizedBox(height: AppSpacing.md),
            FutureBuilder<List<Place>>(
              future: _placesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(message: 'Carregando locais...');
                }

                if (snapshot.hasError) {
                  return Text(
                    'Erro ao carregar locais: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  );
                }

                final places = (snapshot.data ?? []).where((place) {
                  if (_search.isEmpty) return true;

                  return place.title.toLowerCase().contains(_search) ||
                      place.category.toLowerCase().contains(_search);
                }).toList();

                if (places.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      'Nenhum local encontrado.',
                      style: AppTextStyles.small,
                    ),
                  );
                }

                return SizedBox(
                  height: 420,
                  child: ListView.separated(
                    itemCount: places.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final place = places[index];
                      final selected = _isSelected(place);

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: _buildPlaceImage(
                          place,
                          selected: selected,
                        ),
                        title: Text(place.title),
                        subtitle: Text(
                          place.category.isEmpty
                              ? 'Sem categoria'
                              : place.category,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            selected
                                ? Icons.remove_circle
                                : Icons.add_circle,
                            color: selected ? Colors.red : AppColors.primary,
                          ),
                          onPressed: () => _togglePlace(place),
                        ),
                        onTap: () => _togglePlace(place),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.orange.withOpacity(0.5),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.orange),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Dica: adicione locais e defina os horários para criar um roteiro organizado. '
              'A ordem será salva com base nos horários escolhidos.',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar roteiro'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _loading ? null : _saveItinerary,
            child: const Text(
              'SALVAR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderFields(),
            const SizedBox(height: AppSpacing.lg),
            if (isWide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildScheduleCard()),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _buildPlacesCard()),
                ],
              )
            else ...[
              _buildScheduleCard(),
              const SizedBox(height: AppSpacing.lg),
              _buildPlacesCard(),
            ],
            const SizedBox(height: AppSpacing.lg),
            _buildTipCard(),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              text: _loading ? 'Salvando...' : 'Salvar roteiro',
              icon: Icons.save_outlined,
              onPressed: _loading ? null : _saveItinerary,
            ),
          ],
        ),
      ),
    );
  }
}