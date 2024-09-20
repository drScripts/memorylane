import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_lane_challange/config/config.dart';
import 'package:memory_lane_challange/networks/chat_service.dart';
import 'package:memory_lane_challange/ui/screens/chat_room/widgets/chat_bubble.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final ChatService _chatService = ChatService();

  Config config = Get.find();

  String id = Get.parameters['id']!;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final Uuid uuid = const Uuid();

  String? deviceId;
  @override
  void initState() {
    super.initState();

    deviceId = config.deviceId;

    // Scroll to the bottom when the keyboard appears
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) {
      return;
    }

    var message = _controller.text;

    _controller.clear();

    await _chatService.sendMessage(deviceId!, id, message);

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Chat Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                    cursorColor: Colors.black,
                    onSubmitted: (_) => _sendMessage(), // Send message on enter
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blueAccent,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.findMessage(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map(
                (e) => ChatBubble(
                  message: e['text'],
                  isSentByMe: e['ownerId'] == deviceId,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
