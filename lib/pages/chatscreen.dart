import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/helper/global.dart';
import 'package:messenger/pages/auth/somebody_profile.dart';
import 'package:messenger/service/database_service.dart';
import 'package:messenger/helper/helper_function.dart';
import 'package:messenger/service/database_service.dart';
import 'package:messenger/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name, photoUrl,id;
  ChatScreen(this.chatWithUsername, this.name, this.photoUrl,this.id);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String messageId = "";
    Stream? messageStream;
    late String myName, myProfilePic, myUserName, myEmail;
    TextEditingController messageTextEdittingController = TextEditingController();

    getMyInfoFromSharedPreference() async {
    myName = await HelperFunctions().getDisplayName().toString();
    myProfilePic = await HelperFunctions().getUserProfileUrl().toString();
    myUserName = await HelperFunctions().getUserName().toString();
    myEmail = await HelperFunctions().getUserEmail().toString();
    }

    getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
    } else {
    return "$a\_$b";
    }
    }

    addMessage(bool sendClicked) async{
    if (messageTextEdittingController.text != "") {
    String message = messageTextEdittingController.text;

    var lastMessageTs = DateTime.now();

    Map<String, dynamic> messageInfoMap = {
    "message": message,
    "sendBy": await FirebaseAuth.instance.currentUser!.displayName,
    "ts": lastMessageTs,
    "imgUrl": FirebaseAuth.instance.currentUser!.photoURL
    };

    //messageId
    if (messageId == "") {
    messageId = randomAlphaNumeric(12);
    }

    DatabaseService()
        .addMessage(chatRoomId.toString(), messageId, messageInfoMap)
        .then((value) {
    Map<String, dynamic> lastMessageInfoMap = {
    "lastMessage": message,
    "lastMessageSendTs": lastMessageTs,
    "lastMessageSendBy": FirebaseAuth.instance.currentUser!.displayName
    };

    DatabaseService().updateLastMessageSend(chatRoomId.toString(), lastMessageInfoMap);

    if (sendClicked) {
    // remove the text in the message input field
    messageTextEdittingController.text = "";
    // make message id blank to get regenerated on next message send
    messageId = "";
    }
    });
    }
    }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
      sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                  sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                  sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe ? Colors.orange : Colors.blue.shade400,
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            padding: EdgeInsets.only(bottom: 70, top: 16),
            itemCount: snapshot.data.docs.length,
            reverse: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return chatMessageTile(
                  ds["message"], FirebaseAuth.instance.currentUser!.displayName == ds["sendBy"]);
            })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  getAndSetMessages() async {
    messageStream = await DatabaseService().getChatRoomMessages(chatRoomId.toString());
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        Image.asset(
          "assets/fon2.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title:
                Row(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: 45,
                        width: 45,
                        child: FloatingActionButton(
                          onPressed: ()async{
                            DocumentSnapshot doc=await FirebaseFirestore.instance.collection('users').doc(widget.id).get();
                            Images=doc.get('images');
                            CountImages=Images.length;
                            print(Images);
                            print(CountImages);
                            nextScreen(context, SomebodyProfile(uid: widget.id, photoUrl: widget.photoUrl, name: widget.chatWithUsername,));
                          },
                            child: Image.network(widget.photoUrl, fit: BoxFit.cover,width: double.infinity,height: 45,)
                        ),
                      )
                  ),
                  SizedBox(width: 20,),
                  Text(widget.chatWithUsername),
                ],),


            backgroundColor: Colors.transparent,
          ),
          body: Container(
            child: Stack(
              children: [
                chatMessages(),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              controller: messageTextEdittingController,
                              onChanged: (value) {
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "type a message",
                                  hintStyle:
                                  TextStyle(color: Colors.white.withOpacity(0.6))),
                            )),
                        GestureDetector(
                          onTap: () {
                            addMessage(true);
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
