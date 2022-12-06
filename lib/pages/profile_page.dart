import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/pages/profile_edit_page.dart';
import 'package:messenger/service/auth_service.dart';
import 'package:messenger/service/database_service.dart';
import 'package:messenger/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:messenger/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/global.dart';
import '../widgets/bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  String about;
  String age;
  String rost;
  String city;
  String hobbi;
  bool deti;
  String pol;
  ProfilePage({Key? key,
    required this.email,
    required this.userName,
    required this.about,
    required this.age,
    required this.pol,
    required this.deti,
    required this.rost,
    required this.city,
    required this.hobbi,
  })
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseStorage storage=FirebaseStorage.instance;
  String imageUrl=" ";
  XFile? _image;
  TextEditingController? name=TextEditingController();
  late User? user = FirebaseAuth.instance.currentUser;
  void pickUploadImage() async {
    final image=await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );


    Reference ref = FirebaseStorage.instance.ref().child("profilepic${FirebaseAuth.instance.currentUser?.uid}.jpg");


    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value){
      print(value);
      setState(() {
        imageUrl=value;
      });
    });
  }
  AuthService authService = AuthService();



  @override
  Widget build(BuildContext context) {




    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.green,

            )]
          ),
          child: Image.asset(
            "assets/fon.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            scale: 0.6,
          ),
        ),
        Scaffold(
          bottomNavigationBar: MyBottomNavigationBar(),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Профиль",
              style: TextStyle(
                  color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ),
          drawer: MyDrawer(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    (FirebaseAuth.instance.currentUser!.photoURL=="")?ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset(
                          "assets/profile.png",
                          fit: BoxFit.cover,
                          height: 100.0,
                          width: 100.0,))
                        :ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL.toString(),
                          fit: BoxFit.cover,
                          height: 150.0,
                          width: 150.0,)),
                    Positioned(
                      bottom: 0,
                        right: 4,

                        child: ClipOval(

                          child: Container(
                            color: Colors.orange,

                            width: 50,
                            height: 50,
                            child: IconButton(
                              onPressed: () async{

                                GlobalPol=widget.pol;
                                nextScreen(context,
                                    ProfilePageEdit(
                                      email: widget.email,
                                      userName: widget.userName,
                                      about: widget.about,
                                      age: widget.age,
                                      hobbi: widget.hobbi,
                                      deti: widget.deti,
                                      city: widget.city,
                                      rost:widget.rost ,
                                    ));
                              },

                              icon:
                              Icon(Icons.create,color: Colors.white,size: 30,),
                            ),
                          ),
                        ),)

                  ],
                ),
                SizedBox(height: 20,),
                CountImages==0
                    ?Column(
                      children: [
                        Text("Нет фотографий",style: TextStyle(color: Colors.white),),
                        ElevatedButton(onPressed: ()async{

                          XFile? image = await ImagePicker().pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            _image = image;
                          });

                          FirebaseStorage storage = FirebaseStorage.instance;
                          try {
                            await
                            storage.ref(
                                'images-${FirebaseAuth.instance.currentUser!
                                    .displayName}').putFile(File(_image!.path));
                          } on FirebaseException catch (e) {
                            print(e);
                          }
                          var downloadUrl = await storage.ref(
                              'images-${FirebaseAuth.instance.currentUser!
                                  .displayName}').getDownloadURL();

                          AddImages(FirebaseAuth.instance.currentUser!.uid, downloadUrl);
                        }, child: Text("Добавить фотографии",))
                      ],
                    )
                    :Column(
                      children: [
                        Container(
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
                        ElevatedButton(onPressed: ()async{

                          XFile? image = await ImagePicker().pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            _image = image;
                          });

                          FirebaseStorage storage = FirebaseStorage.instance;
                          try {
                            await
                            storage.ref(
                                'images-${FirebaseAuth.instance.currentUser!
                                    .displayName}-${_image!.name}').putFile(File(_image!.path));
                          } on FirebaseException catch (e) {
                            print(e);
                          }
                          var downloadUrl = await storage.ref(
                              'images-${FirebaseAuth.instance.currentUser!
                                  .displayName}-${_image!.name}').getDownloadURL();

                          AddImages(FirebaseAuth.instance.currentUser!.uid, downloadUrl);
                        }, child: Text("Добавить фотографии",))
                      ],
                    ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Имя", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                    Row(
                      children: [
                        Text(user!.displayName.toString(), style: const TextStyle(fontSize: 17,color: Colors.white)),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Email", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(user!.email.toString(), style: const TextStyle(fontSize: 17,color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Возраст", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(widget.age.toString(),
                        style: const TextStyle(fontSize: 17,color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Группа", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Рост", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(
                        widget.rost.toString(),
                        style: const TextStyle(fontSize: 17,color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Пол", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(
                        widget.pol.toString(),
                        style: const TextStyle(fontSize: 17,color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Наличие детей", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(
                        widget.deti
                        ?"Есть"
                        :"Нет",
                        style: const TextStyle(fontSize: 17,color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Город", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(
                        widget.city.toString(),
                        style: const TextStyle(fontSize: 17,color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Хобби", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(
                        widget.hobbi.toString(),
                        style: const TextStyle(fontSize: 17,color: Colors.white)),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("О себе", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.left),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(widget.about.toString(),
                                style: const TextStyle(fontSize: 17,color: Colors.white),textAlign: TextAlign.left,softWrap: true,),
                          ),
                        ],
                      )


                    ],
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ],
    );

  }


  AddImages(String uid,String url)async{
    await FirebaseFirestore.instance.collection('users')
        .doc(uid)
        .update({
      "images":FieldValue.arrayUnion([url])
    });

  }
}



