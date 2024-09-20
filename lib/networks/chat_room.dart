import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_lane_challange/common/helpers/string_format.dart';
import 'package:memory_lane_challange/entities/chat_room.dart';
import 'package:uuid/uuid.dart';

class ChatRoomService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future<ChatRoomEntity> createChatRoomService(String deviceId) async {
    const uuid = Uuid();

    ChatRoomEntity chatRoom = ChatRoomEntity(
      id: uuid.v4(),
      lastChat: "-",
      title: "New Chat",
      updatedAt: dateISOString(),
      createdAt: dateISOString(),
      deviceId: deviceId,
    );

    await _fireStore.collection("rooms").doc(chatRoom.id).set(chatRoom.toMap());

    return chatRoom;
  }

  Stream<QuerySnapshot> findRooms(String deviceId) {
    return _fireStore
        .collection("rooms")
        .orderBy("updatedAt", descending: false)
        .snapshots();
  }
}
