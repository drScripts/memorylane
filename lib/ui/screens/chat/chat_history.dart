import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_lane_challange/common/helpers/string_format.dart';
import 'package:memory_lane_challange/config/config.dart';
import 'package:memory_lane_challange/networks/chat_room.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({
    super.key,
  });

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  final ChatRoomService _chatRoomService = ChatRoomService();
  Config config = Get.find();

  String? deviceId;

  @override
  void initState() {
    super.initState();

    deviceId = config.deviceId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed, // 'Add' icon inside the button
        backgroundColor: Colors
            .blueAccent, // Define this function to handle the button press
        child: const Icon(Icons.add), // Customize the color as you like
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff135CAF),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/image/white_logo.png',
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        child: _buildMessageList(),
      ),
    );
  }

  // Function to handle what happens when the FAB is pressed
  void _onAddPressed() async {
    var response = await _chatRoomService.createChatRoomService(deviceId!);

    Get.toNamed(
      '/chats/${response.id}',
    ); // Passing id as a string
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatRoomService.findRooms(deviceId!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs.map(
            (e) {
              return e['deviceId'] == deviceId
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          '/chats/${e.id}',
                        ); // Passing id as a string
                      },
                      child: Container(
                        color: Colors.grey[100],
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e['title'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  e['lastChat'],
                                  style: const TextStyle(
                                    color: Color(0xff9A9BB1),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              formatCustomDate(e['updatedAt']),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox();
            },
          ).toList(),
        );
      },
    );
  }
}
