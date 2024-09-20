import 'package:get/get.dart';
import 'package:memory_lane_challange/networks/chat_service.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService();

  Future<void> sendMessage(String deviceId, String roomId, String text) async {
    await _chatService.sendMessage(deviceId, roomId, text);
  }

}
