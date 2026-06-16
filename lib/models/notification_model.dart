class NotificationModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description Available',
      imageUrl: json['thumbnail'] ?? '',
      isRead: (json['id'] % 2 == 0),
    );
  }
}
