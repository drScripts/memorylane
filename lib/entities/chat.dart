class ChatEntity {
  final String id;
  final String text;
  final String ownerId;
  final String createdAt;

  ChatEntity({
    required this.id,
    required this.text,
    required this.ownerId,
    required this.createdAt,
  });

  // Convert ChatEntity to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'ownerId': ownerId,
      'createdAt': createdAt,
    };
  }
}
