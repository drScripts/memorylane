import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:memory_lane_challange/common/helpers/string_format.dart';
import 'package:memory_lane_challange/entities/chat.dart';
import 'package:uuid/uuid.dart';

class ChatService {
  final _gemini = Gemini.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String deviceId, String roomId, String message) async {
    const uuid = Uuid();

    print("MESSAGEE ${message}");

    ChatEntity chat = ChatEntity(
      id: uuid.v4(),
      text: message,
      ownerId: deviceId,
      createdAt: dateISOString(),
    );

    await _fireStore.collection("rooms").doc(roomId).update({
      "updatedAt": dateISOString(),
      "lastChat": message,
    });

    print("CHAT ${chat.toMap()} ${message}");

    await _fireStore
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .add(chat.toMap());

    _gemini.text(message).then(
      (value) {
        print("VALUEE $value");
        if (value?.output != null) {
          _fireStore.collection("rooms").doc(roomId).update({
            "updatedAt": dateISOString(),
            "lastChat": value?.output!,
          });

          ChatEntity chat = ChatEntity(
            id: uuid.v4(),
            text: value!.output!,
            ownerId: "GEMINI_BOT",
            createdAt: dateISOString(),
          );

          _fireStore
              .collection("rooms")
              .doc(roomId)
              .collection("messages")
              .add(chat.toMap());
        }
      },
    ).catchError(
      (error) {
        print("ERROR $error");
      },
    );
  }

  Stream<QuerySnapshot> findMessage(String roomId) {
    return _fireStore
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .orderBy("createdAt", descending: false)
        .snapshots();
  }
}
