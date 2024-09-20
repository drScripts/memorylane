import 'package:get/get.dart';
import 'package:memory_lane_challange/ui/screens/chat/chat_history.dart';
import 'package:memory_lane_challange/ui/screens/chat_room/chat_room.dart';
import 'package:memory_lane_challange/ui/screens/splashscreen/splash_page.dart';

class Routes {
  static final pages = [
    GetPage(
      name: "/",
      page: () => const SplashPage(),
    ),
    GetPage(
      name: "/chats",
      page: () => const ChatHistory(),
    ),
    GetPage(
      name: "/chats/:id",
      page: () => const ChatRoom(),
    ),
  ];
}
