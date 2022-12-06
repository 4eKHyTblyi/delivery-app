import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/pages/home_page.dart';
import 'package:messenger/pages/profile_page.dart';
import 'package:messenger/pages/profiles_list.dart';
import 'package:messenger/widgets/widgets.dart';

import '../helper/global.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}
int _selectedIndex = selectedIndex;

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {



  void _onItemTapped(int index)async {


    setState(() {
      _selectedIndex = index;
    });






    switch(index){

      case 0:
        DocumentSnapshot doc=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
        Images=doc.get('images');
        CountImages=Images.length;
        print(Images);
        print(CountImages);

        await FirebaseFirestore.instance.collection("users").where("fullName", isEqualTo: FirebaseAuth.instance.currentUser!.displayName.toString()).get().then((QuerySnapshot snapshot) {
          GlobalAge=snapshot.docs[0].get("age".toString()).toString();
          GlobalAbout=snapshot.docs[0].get("about".toString()).toString();
          GlobalCity=snapshot.docs[0]["city"].toString();
          GlobalHobbi=snapshot.docs[0]["hobbi"];
          GlobalRost=snapshot.docs[0]["rost"];
          GlobalDeti=snapshot.docs[0]["deti"];
          Group=snapshot.docs[0]["группа"];
          GlobalPol=snapshot.docs[0]["пол"];
        });
        nextScreen(context,
          ProfilePage(
              email: FirebaseAuth.instance.currentUser!.email.toString(),
              userName: FirebaseAuth.instance.currentUser!.displayName.toString(),
              about: GlobalAbout.toString(),
              age: GlobalAge.toString(),
            rost: GlobalRost.toString(),
            hobbi: GlobalHobbi.toString(),
            city: GlobalCity.toString(),
            deti: GlobalDeti,
            pol: GlobalPol.toString(),
          ));
      break;
      case 1: nextScreen(context, HomePage());
      break;
      case 2:
        await FirebaseFirestore.instance.collection("users").where("fullName", isEqualTo: FirebaseAuth.instance.currentUser!.displayName.toString()).get().then((QuerySnapshot snapshot) {
          GlobalAge=snapshot.docs[0].get("age".toString()).toString();
          GlobalAbout=snapshot.docs[0].get("about".toString()).toString();
          GlobalCity=snapshot.docs[0]["city"].toString();
          GlobalHobbi=snapshot.docs[0]["hobbi"];
          GlobalRost=snapshot.docs[0]["rost"];
          GlobalDeti=snapshot.docs[0]["deti"];
          Group=snapshot.docs[0]["группа"];
          GlobalPol=snapshot.docs[0]["пол"];
        });
        nextScreen(context,
          ProfilesList(
              email: FirebaseAuth.instance.currentUser!.email.toString(),
              userName: FirebaseAuth.instance.currentUser!.displayName.toString(),
          ));
      break;

    };
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Профиль"),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined),label: "Чаты"),
          BottomNavigationBarItem(icon: Icon(Icons.people),label: "Пользователи"),

        ],
      currentIndex:  _selectedIndex,
      onTap: _onItemTapped,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
    )
    ;
  }
}
