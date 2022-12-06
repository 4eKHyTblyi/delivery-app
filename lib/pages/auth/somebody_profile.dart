import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:messenger/helper/global.dart';
import 'package:messenger/pages/home_page.dart';
import 'package:messenger/service/database_service.dart';
import 'package:messenger/widgets/drawer.dart';
import 'package:messenger/widgets/widgets.dart';

import '../../widgets/bottom_nav_bar.dart';

class SomebodyProfile extends StatefulWidget {
  String uid;
  String photoUrl;
  String name;
  SomebodyProfile({Key? key, required this.uid,required this.photoUrl, required this.name})
      : super(key: key);

  @override
  State<SomebodyProfile> createState() => _SomebodyProfileState();
}

class _SomebodyProfileState extends State<SomebodyProfile> {


  CollectionReference users=FirebaseFirestore.instance.collection("users");
  getChatRoomIdByUsernames(String a, String b) {
    if(a.isNotEmpty && b.isNotEmpty) {
      if (a.substring(0, 1).codeUnitAt(0) <= b.substring(0, 1).codeUnitAt(0)) {
        return "$a\_$b";
      } else {
        return "$b\_$a";
      }
    }
    else {
      return "abrakadabra";
    }
  }

  @override
  Widget build(BuildContext context) {



    bool HaveOrNot=false;

    // Future NicknameOfUid(String uid) async {
    //   dynamic nickname;
    //   await FirebaseFirestore.instance.collection("users").doc(uid).get().then((doc) {
    //     nickname=doc['fullName'];
    //     photoUrl=doc['profilePic'];
    //
    //   });
    //   nickName=nickname;
    //   return nickname;
    //
    // }




    BuildSomebodyProfile(
        ){
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
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
          title: Text(widget.name,style: TextStyle(color: Colors.white),)

          ),
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),

              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 17),
                height: MediaQuery.of(context).size.height+100,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      (widget.photoUrl=="")
                      ?ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        "assets/profile.png",
                        fit: BoxFit.cover,
                        height: 150.0,
                        width: 150.0,))
                      :ClipRRect(

                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            widget.photoUrl.toString(),
                            fit: BoxFit.cover,
                            height: 150.0,
                            width: 150.0,)),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                      CountImages==0
                      ?Text("Нет фотографий",style: TextStyle(color: Colors.white),)
                      :Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                            itemBuilder:(BuildContext, int index){
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft:Radius.circular(15) )
                                ),

                                height: 300,
                                child: InkWell(

                                    onTap: (){
                                      showDialog(

                                          builder: (context)=>AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            insetPadding: EdgeInsets.all(2),
                                            title: Container(
                                              decoration: BoxDecoration(),
                                              width: MediaQuery.of(context).size.width,
                                              child: Container(
                                                child: Image.network(
                                                  Images[index],
                                                ),
                                              ),
                                            ),
                                          ),
                                          context: context,
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 5),
                                      width: 100,
                                      child: Image.network(
                                          Images[index],fit: BoxFit.cover
                                      ),
                                    )),
                              );

                            },
                            itemCount: CountImages,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.name,style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal
                          ),),
                          Row(
                            children: [
                              IconButton(onPressed: () async{

                                Map<String, dynamic> chatRoomInfoMap = {
                                  "user1":FirebaseAuth.instance.currentUser!.displayName.toString(),
                                  "user2":widget.name,
                                  "user1_image":FirebaseAuth.instance.currentUser!.photoURL,
                                  "user2_image":widget.photoUrl,
                                  "lastMessage":"",
                                  "chatId":getChatRoomIdByUsernames(FirebaseAuth.instance.currentUser!.displayName.toString(), widget.name)
                                };
                                // await FirebaseFirestore.instance.collection("chats").where("chatId", isEqualTo: getChatRoomIdByUsernames(FirebaseAuth.instance.currentUser!.displayName.toString(), fullName))==null
                                // ?DatabaseService().createChatRoom(getChatRoomIdByUsernames(FirebaseAuth.instance.currentUser!.displayName.toString(), fullName),chatRoomInfoMap)
                                // :nextScreen(context, HomePage());
                                await FirebaseFirestore.instance.collection("chats")
                                    .where("chatId", isEqualTo: getChatRoomIdByUsernames(widget.name,FirebaseAuth.instance.currentUser!.displayName.toString() ))
                                    .get()
                                    .then((QuerySnapshot snapshot) {
                                      print(1);
                                      if(snapshot.docs.isEmpty){
                                        print(false);
                                      }
                                      else{
                                        HaveOrNot=true;
                                        print(true);
                                      }
                                });
                                await FirebaseFirestore.instance.collection("chats")
                                    .where("chatId", isEqualTo: getChatRoomIdByUsernames(FirebaseAuth.instance.currentUser!.displayName.toString(), widget.name))
                                    .get()
                                    .then((QuerySnapshot snapshot) {
                                  print(1);
                                  if(snapshot.docs.isEmpty){
                                  }
                                  else{
                                    HaveOrNot=true;
                                    print(true);
                                  }
                                  if(HaveOrNot==false){
                                    DatabaseService().createChatRoom(getChatRoomIdByUsernames(FirebaseAuth.instance.currentUser!.displayName.toString(), widget.name),chatRoomInfoMap);
                                    DatabaseService().addChat(FirebaseAuth.instance.currentUser!.uid, getChatRoomIdByUsernames(FirebaseAuth.instance.currentUser!.displayName.toString(), widget.name));
                                    DatabaseService().addChatSecondUser(widget.uid, getChatRoomIdByUsernames(FirebaseAuth.instance.currentUser!.displayName.toString(), widget.name));

                                  }
                                  else{
                                    nextScreen(context, HomePage());
                                  }
                                  nextScreen(context, HomePage());
                                });
                              },
                                  icon:
                                  Icon(
                                    Icons.messenger_outline,
                                    color: Colors.orange,
                                    size: 35,)),
                              IconButton(onPressed: (){showSnackbar(context, Colors.green, "Спасибо за отклик! Мы уже рассматриваем заявку.");}, icon: Icon(Icons.feedback_rounded,size: 35,color: Colors.red,),),
                            ],
                          )
                        ],
                      ),
                      FutureBuilder(
                        future: users.doc(widget.uid).get(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                          if(snapshot.connectionState==ConnectionState.done){
                            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Возраст: ",style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),),
                                    Text(data['age'].toString(),style: TextStyle(color: Colors.white,fontSize: 21),)
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Рост: ",style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),),
                                    Text(data['rost'],style: TextStyle(color: Colors.white,fontSize: 21),)
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      Text("Хобби: ",style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),softWrap: true,textAlign: TextAlign.left,),
                                      Text(data['hobbi']!=""?data['hobbi']:"не заполнено",style: TextStyle(color: Colors.white,fontSize: 21),softWrap: true,)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Дети: ",style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),),
                                    Text(data['deti']?"есть":"нет",style: TextStyle(color: Colors.white,fontSize: 21),)
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text("О себе", style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.left),
                                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                                      Column(

                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: Container(
                                              child: new Text(data['about'],
                                                style: const TextStyle(fontSize: 21,color: Colors.white),textAlign: TextAlign.center,softWrap: true,),
                                            ),
                                          ),
                                        ],
                                      )


                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          else{
                            return Text('Загрузка... ');
                          }
                          return Text('Загрузка...');
                          }

                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    };

    return BuildSomebodyProfile();


    //);
  }
}
