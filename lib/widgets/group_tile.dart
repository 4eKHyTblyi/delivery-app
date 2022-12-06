import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/pages/chat_page.dart';
import 'package:messenger/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatefulWidget {
  final String userName;
  final String chatId;
  final String userName2;
  const ChatTile(
      {Key? key,
      required this.chatId,
      required this.userName2,
      required this.userName})
      : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
              groupId: widget.chatId,
              groupName: widget.userName2,
              email: widget.userName,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.userName2.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.userName2,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${widget.userName} ${FirebaseFirestore.instance.collection("chats")}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
