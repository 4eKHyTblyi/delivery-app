import 'package:messenger/helper/global.dart';
import 'package:messenger/helper/helper_function.dart';
import 'package:messenger/pages/chatscreen.dart';
import 'package:messenger/service/auth_service.dart';
import 'package:messenger/service/database_service.dart';
import 'package:messenger/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/widgets/widgets.dart';

import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? chats;
  String id="";
  String photoUrl = "";

  bool isSearching = false;
  Stream? usersStream, chatRoomsStream;
  late String myName, myProfilePic, myUserName, myEmail;
  TextEditingController searchUsernameEditingController =
  TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = await HelperFunctions().getDisplayName().toString();
    myProfilePic = await HelperFunctions().getUserProfileUrl().toString();
    myUserName = await HelperFunctions().getUserName().toString();
    myEmail = await HelperFunctions().getUserEmail().toString();
  }

  getChatRooms() async {
    chatRoomsStream = await DatabaseService().getChatRooms();
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream = await DatabaseService()
        .getUserByUserName(searchUsernameEditingController.text);

    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  chatRoomsList(AsyncSnapshot<QuerySnapshot> snapshot,String MyNickname) {
    String nick, userNum;
    return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    padding: EdgeInsets.symmetric(horizontal: 2.0),
    itemCount: ((snapshot.data! as QuerySnapshot).docs.length),
    itemBuilder: (BuildContext context, int index){

      return snapshot.data!.docs[index].get("user1")==MyNickname || snapshot.data!.docs[index].get("user2")==MyNickname
          ?Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.0),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
              subtitle:
              snapshot.data!.docs[index]["lastMessage"]!=""
              ?Text("${

                  snapshot.data!.docs[index]["lastMessageSendBy"]==MyNickname
                      ?"Вы"
                      :snapshot.data!.docs[index]["lastMessageSendBy"]

              }: ${snapshot.data!.docs[index].get("lastMessage")}",style: TextStyle(color: Colors.white),)
              :Text("нет сообщений",style: TextStyle(color: Colors.white),),
              title:
              snapshot.data!.docs[index].get("user1")==MyNickname
                ?Text(snapshot.data!.docs[index].get("user2"),style: TextStyle(color: Colors.white),)
                :Text(snapshot.data!.docs[index].get("user1"),style: TextStyle(color: Colors.white),)
              ,
              onTap: () async {
                snapshot.data!.docs[index].get("user1")==MyNickname
                ?nick=snapshot.data!.docs[index].get("user2")
                :nick=snapshot.data!.docs[index].get("user1");


                await FirebaseFirestore.instance.collection("chats").where("chatId",isEqualTo: getChatRoomIdByUsernames(nick, MyNickname)).get().then((QuerySnapshot snapshot) {
                  if(snapshot.docs.isEmpty){
                    chatRoomId=getChatRoomIdByUsernames(MyNickname,nick);
                  }
                  else{
                    chatRoomId=getChatRoomIdByUsernames(nick, MyNickname);
                  }
                });

                await FirebaseFirestore.instance.collection("users").where("fullName", isEqualTo: nick).get().then((QuerySnapshot snapshot) {
                  id=snapshot.docs[0].id;
                  photoUrl=snapshot.docs[0].get("profilePic");});

                setState(() {
                  nextScreen(context, ChatScreen(nick, MyNickname,photoUrl,id));
                });
                print(chatRoomId);

                },

              leading:
              ClipRRect(

                borderRadius: BorderRadius.circular(100.0),
                child:
                snapshot.data!.docs[index].get("user1")==MyNickname
                    ?snapshot.data!.docs[index].get("user2_image")!=""
                      ?Image.network(snapshot.data!.docs[index].get("user2_image"),

                        width: 60,
                        height: 100,
                        fit: BoxFit.cover,)
                      :Container(color: Colors.white,padding: EdgeInsets.all(8),child: Icon(Icons.person,size: 40))
                    :snapshot.data!.docs[index].get("user1_image")!=""
                      ?Image.network(snapshot.data!.docs[index].get("user1_image"),

                        width: 60,
                        height: 100,
                        fit: BoxFit.cover,)
                      :Container(color: Colors.white,padding: EdgeInsets.all(8),child: Icon(Icons.person,size: 40)),



                ),

        tileColor: Colors.white24,
        contentPadding: EdgeInsets.all(10.0),
      ),
          )
          :Container();
    },
    );

}

  // Widget searchUsersList() {
  //   return StreamBuilder(
  //     stream: usersStream,
  //     builder: (context, snapshot) {
  //       return snapshot.hasData
  //           ? ListView.builder(
  //         itemCount: snapshot.data.docs.length,
  //         shrinkWrap: true,
  //         itemBuilder: (context, index) {
  //           DocumentSnapshot ds = snapshot.data.docs[index];
  //           return searchListUserTile(
  //               profileUrl: ds["imgUrl"],
  //               name: ds["name"],
  //               email: ds["email"],
  //               username: ds["username"]);
  //         },
  //       )
  //           : Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     },
  //   );
  // }
  // Widget searchListUserTile({String? profileUrl, name, username, email}) {
  //   return GestureDetector(
  //     onTap: () {
  //       var chatRoomId = getChatRoomIdByUsernames(myUserName, username);
  //       Map<String, dynamic> chatRoomInfoMap = {
  //         "users": [myUserName, username]
  //       };
  //       DatabaseService().createChatRoom(chatRoomId, chatRoomInfoMap);
  //       Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //       builder: (context) => ChatScreen(username, name)));
  //     },
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 8),
  //       child: Row(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(40),
  //             child: Image.network(
  //               profileUrl!,
  //               height: 40,
  //               width: 40,
  //             ),
  //           ),
  //           SizedBox(width: 12),
  //           Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [Text(name), Text(email)])
  //         ],
  //       ),
  //     ),
  //   );
  // }



  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        chats = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/fon.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          bottomNavigationBar: MyBottomNavigationBar(),
          backgroundColor: Colors.transparent,

            appBar: AppBar(
              actions: [
                // IconButton(
                //     onPressed: () {
                //       nextScreen(context, const SearchPage());
                //     },
                //     icon: const Icon(
                //       Icons.search,
                //     ))
              ],
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: const Text(
                "Чаты",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
              ),
            ),
            drawer: MyDrawer(),
            body: SingleChildScrollView(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('chats')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Нет чатов", textAlign: TextAlign.center,);
                      }
                      else {
                        return chatRoomsList(snapshot, FirebaseAuth.instance.currentUser!.displayName.toString());

                      }
                    }
                )
            )
        ),
      ],
    );
  }

}
