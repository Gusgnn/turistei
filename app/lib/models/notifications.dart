class AppNotification {
  final String id;
  final String title;
  final String message;
  final String date;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
  });
}