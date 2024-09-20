class ChatRoomEntity {
  final String id;
  final String title;
  final String lastChat;
  final String createdAt;
  final String updatedAt;
  final String deviceId;

  ChatRoomEntity({
    required this.id,
    required this.title,
    required this.lastChat,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'lastChat': lastChat,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deviceId': deviceId,
    };
  }
}
