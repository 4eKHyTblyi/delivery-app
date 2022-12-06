import 'package:messenger/service/database_service.dart';
import 'package:messenger/widgets/message_tile.dart';
import 'package:messenger/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String email;
  const ChatPage(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.email})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(widget.groupName),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              chatMessages(),
              const Padding(padding: EdgeInsets.only(bottom: 50.0)),

              Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[700],

                child: Row(children: [
                  Expanded(
                      child: TextFormField(
                        controller: messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Отправить сообщение...",
                          hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  )
                ]),
              ),
                )
              // chat messages here

            ],
          ),
        ),
    );
  }

  chatMessages() {
    return StreamBuilder(
        stream: chats,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 70, top:16),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        message: snapshot.data.docs[index]['message'],
                        sender: snapshot.data.docs[index]['sender'],
                        sentByMe: widget.email ==
                            snapshot.data.docs[index]['sender']);

                  },
                )
              : Container();
        },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.email,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear(
        );
      });
    }
  }

  Future<bool> onBackPress() {
    return Future.value(false);
  }
}

