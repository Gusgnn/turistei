class NotificationModel {
  final String id;
  final String title;
  final String message;
  final bool read;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.read,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: json['titulo']?.toString() ??
          json['title']?.toString() ??
          'Notificação',
      message: json['mensagem']?.toString() ??
          json['message']?.toString() ??
          json['descricao']?.toString() ??
          '',
      read: json['lida'] == true || json['read'] == true,
      createdAt: json['criadoEm']?.toString() ??
          json['createdAt']?.toString() ??
          json['created_at']?.toString() ??
          '',
    );
  }
}