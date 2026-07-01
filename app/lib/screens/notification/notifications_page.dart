import 'package:flutter/material.dart';

import '../../models/notification_model.dart';
import '../../services/notification_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_radius.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/loading_widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationService _notificationService = NotificationService();

  Future<List<NotificationModel>>? _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    _notificationsFuture = _notificationService.getNotifications();
  }

  Future<void> _markAsRead(NotificationModel notification) async {
    if (notification.read) return;

    try {
      await _notificationService.markAsRead(notification.id);

      setState(() {
        _loadNotifications();
      });
    } catch (_) {}
  }

  Future<void> _deleteNotification(NotificationModel notification) async {
    try {
      await _notificationService.deleteNotification(notification.id);

      setState(() {
        _loadNotifications();
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notificação removida.'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao remover notificação: $e'),
        ),
      );
    }
  }

  IconData _getIcon(NotificationModel notification) {
    final text = '${notification.title} ${notification.message}'.toLowerCase();

    if (text.contains('evento')) return Icons.event;
    if (text.contains('roteiro')) return Icons.map_outlined;
    if (text.contains('local') || text.contains('lugar')) {
      return Icons.place_outlined;
    }
    if (text.contains('favorito')) return Icons.favorite_border;

    return Icons.notifications_outlined;
  }

  Color _getColor(NotificationModel notification) {
    final text = '${notification.title} ${notification.message}'.toLowerCase();

    if (text.contains('evento')) return AppColors.primary;
    if (text.contains('roteiro')) return AppColors.secondary;
    if (text.contains('local') || text.contains('lugar')) {
      return AppColors.tertiary;
    }

    return AppColors.accent;
  }

  String _formatDate(String value) {
    if (value.isEmpty) return 'Agora';

    final date = DateTime.tryParse(value);

    if (date == null) return value;

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (_notificationsFuture == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(
              message: 'Carregando notificações...',
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'Erro ao carregar notificações: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final notifications = snapshot.data ?? [];

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma notificação encontrada.',
                style: AppTextStyles.small,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: notifications.length,
            separatorBuilder: (_, __) {
              return const SizedBox(height: AppSpacing.md);
            },
            itemBuilder: (context, index) {
              final item = notifications[index];

              return Dismissible(
                key: ValueKey(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (_) => _deleteNotification(item),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppRadius.large),
                  onTap: () => _markAsRead(item),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: item.read
                          ? AppColors.surface
                          : AppColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppRadius.large),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: _getColor(item),
                          child: Icon(
                            _getIcon(item),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: AppTextStyles.body.copyWith(
                                  fontWeight: item.read
                                      ? FontWeight.w600
                                      : FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                item.message,
                                style: AppTextStyles.small,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                _formatDate(item.createdAt),
                                style: AppTextStyles.small.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}