
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:messenger/helper/global.dart';
import 'package:messenger/helper/helper_function.dart';
import 'package:messenger/pages/auth/somebody_profile.dart';
import 'package:messenger/service/auth_service.dart';
import 'package:messenger/widgets/drawer.dart';
import 'package:messenger/service/database_service.dart';
import 'package:messenger/widgets/widgets.dart';

import '../widgets/bottom_nav_bar.dart';
import 'filter_pages/filter_page.dart';

// ignore: must_be_immutable
class ProfilesList extends StatefulWidget {

  String userName;
  String email;
  ProfilesList({Key? key, required this.email, required this.userName})
      : super(key: key);

  @override

  State<ProfilesList> createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesList> {
  AuthService authService = AuthService();

  String myUserName="";



  getGroup()async{
    String group="";
    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((data) {
      group=data.get('группа');
    });
    return group;
  }
  getMyInfoFromSharedPreference() async {
    //myName = await SharedPreferenceHelper().getDisplayName();
    //myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = HelperFunctions().getUserName().toString();
    //myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  get user => auth.currentUser;
  get uid => user?.uid;

  late FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
  get users=>firebaseFirestore.collection("users").snapshots();
   int age = int.parse(GlobalAge.toString());

  final collection=FirebaseFirestore.instance
      .collection('users')
      // .where("uid",isLessThan: FirebaseAuth.instance.currentUser!.uid )
      //.where("uid","in",[isGreaterThan: FirebaseAuth.instance.currentUser!.uid,isLessThan: FirebaseAuth.instance.currentUser!.uid])
      .where("age",
      whereIn: [
        int.parse(GlobalAge.toString())-3,
        int.parse(GlobalAge.toString())-2,
        int.parse(GlobalAge.toString())-1,
        int.parse(GlobalAge.toString()),
        int.parse(GlobalAge.toString())+3,
        int.parse(GlobalAge.toString())+2,
        int.parse(GlobalAge.toString())+1])
      .where("uid",isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)


  ;
  


  getNeedList(){

  }
  String? pol;


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
          bottomNavigationBar: const MyBottomNavigationBar(),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: [Builder(
              builder: (context) {
                return IconButton(icon: const Icon(Icons.filter_alt_rounded),onPressed: (){
                  Navigator.of(context).push(createRoute(()=>const FilterPage()));
                },);
              }
            ),],
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Пользователи",
              style: TextStyle(
                  color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ),
          drawer: const MyDrawer(),
          body: SingleChildScrollView(
            child: Group=="красно-зелёная" || Group=="красно-белая" || Group=="красно-оранжевая"
                ?StreamBuilder<QuerySnapshot>(
                      stream:collection
                          //.where("age", isGreaterThan: 10)
                            //.where("группа", whereIn: ["зелёно-белая","бело-красная","бело-зелёная","бело-оранжевая","оранжево-белая","1"])
                            // .orderBy('uid',descending: true)
                            // .orderBy('age',descending: true)
                            .snapshots()//.takeWhile((element) => element.docs[0]["age"]>=20)

                ,

                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData){
                            return const Center(child: Text("Пользователи не найдены"));
                          }
                          return createTable(snapshot);
                          // return Table(
                          //   children: [
                          //     TableRow(
                          //       //children: getExpenseItems(snapshot)
                          //       children: createTable()
                          //     )
                          //   ],
                          // );
                                //ListView(children:getExpenseItems(snapshot));
                        }
            )
                :Group=="зелёно-красная" || Group=="зелёно-белая" || Group=="зелёно-оранжевая"
                  ?StreamBuilder<QuerySnapshot>(
                stream:collection
                    .where("группа",
                    whereIn: <String>["красно-белая","оранжево-красная","оранжево-зелёная","красно-оранжевая","оранжево-белая"])
                    .orderBy('uid',descending: true)
                    .snapshots(),

                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData){
                    return const Center(child: Text("Пользователи не найдены"));
                  }
                  return createTable(snapshot);
                  // return Table(
                  //   children: [
                  //     TableRow(
                  //       //children: getExpenseItems(snapshot)
                  //       children: createTable()
                  //     )
                  //   ],
                  // );
                  //ListView(children:getExpenseItems(snapshot));
                }
            )
                  :Group=="бело-красная" || Group=="бело-зелёная" || Group=="бело-оранжевая"
                    ?StreamBuilder<QuerySnapshot>(
                    stream:collection
                        .where("группа",
                        whereIn: ["красно-белая","красно-зелёная","красно-оранжевая","оранжево-белая"])
                        .orderBy('uid',descending: true)
                        .snapshots(),

                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData){
                        return const Center(child: Text("Пользователи не найдены"));
                      }
                      return createTable(snapshot);
                      // return Table(
                      //   children: [
                      //     TableRow(
                      //       //children: getExpenseItems(snapshot)
                      //       children: createTable()
                      //     )
                      //   ],
                      // );
                      //ListView(children:getExpenseItems(snapshot));
                    }
                )
                    :Group=="оранжево-красная" || Group=="оранжево-белая" || Group=="оранжево-зелёная"
                      ?StreamBuilder<QuerySnapshot>(
                      stream:collection
                          .where("группа",
                          whereIn: ["зелёно-белая","оранжево-зелёная","зелёно-оранжевая"])
                          .orderBy('uid',descending: true)
                          .snapshots(),

                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData){
                          return const Center(child: Text("Пользователи не найдены"));
                        }
                        return createTable(snapshot);
                        // return Table(
                        //   children: [
                        //     TableRow(
                        //       //children: getExpenseItems(snapshot)
                        //       children: createTable()
                        //     )
                        //   ],
                        // );
                        //ListView(children:getExpenseItems(snapshot));
                      }
                  )
                      :Group=="оранжево-белая"
                        ?StreamBuilder<QuerySnapshot>(
                        stream:collection
                            .where("группа",
                            whereIn: ["красно-зелёная","бело-красная","красно-оранжевая","зелёно-белая","зелёно-красная","зелёно-оранжевая"])
                            .orderBy('uid',descending: true)
                            .snapshots(),

                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData){
                            return const Center(child: Text("Пользователи не найдены"));
                          }
                          return createTable(snapshot);
                          // return Table(
                          //   children: [
                          //     TableRow(
                          //       //children: getExpenseItems(snapshot)
                          //       children: createTable()
                          //     )
                          //   ],
                          // );
                          //ListView(children:getExpenseItems(snapshot));
                        }
                    )
                        :const Center(child: Text("Пользователи не найдены"))
          ),
        ),
      ],
    );

  }
  Widget createTable(AsyncSnapshot<QuerySnapshot> snapshot) {
    getMyInfoFromSharedPreference();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 3),
      itemCount: snapshot.data!.docs.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index)
      {

        return
          //snapshot.data!.docs[index]["age"]>=10 && snapshot.data!.docs[index]["age"]<=19
       Padding(
            padding: const EdgeInsets.symmetric(horizontal:3, vertical: 3),
            child: GestureDetector(

            onTap: () async {

              DocumentSnapshot doc=await FirebaseFirestore.instance.collection('users').doc(snapshot.data!.docs[index].id).get();
              Images=doc.get('images');
              CountImages=Images.length;


              DatabaseService().getUserByUserName(snapshot.data!.docs[index].get("fullName"));


              setState(() {
                somebodyUid= snapshot.data!.docs[index].get("uid");
                somebodyFullname= snapshot.data!.docs[index].get("fullName");
                somebodyImageUrl= snapshot.data!.docs[index].get("profilePic");
              });
              // ignore: use_build_context_synchronously
              nextScreen(context, SomebodyProfile(uid: somebodyUid.toString(),name: somebodyFullname.toString(),photoUrl: somebodyImageUrl.toString(),));

            },

            child: Container(
              decoration: BoxDecoration(
                image: (snapshot.data!.docs[index].get("profilePic")=="")
                ?const DecorationImage(
                    image: AssetImage("assets/profile.png"),fit: BoxFit.cover)
                : DecorationImage(
                  image:NetworkImage(snapshot.data!.docs[index].get("profilePic").toString()),fit: BoxFit.cover),),
              child:
                Container(
                  color: Colors.black38,
                  padding:const EdgeInsets.symmetric(vertical: 2),
                  margin:const EdgeInsets.only(top: 110),
                    child: Text("${snapshot.data!.docs[index].get("fullName")}, ${snapshot.data!.docs[index].get("age")}", style:const TextStyle(color: Colors.white),textAlign: TextAlign.center,))
            ),
              // decoration: BoxDecoration(
              //     image:
              //     (snapshot.data!.docs[index].get("profilePic")=="")
              //         ? DecorationImage(image: AssetImage("assets/profile.png"))
              //         : DecorationImage(image: NetworkImage(snapshot.data!.docs[index].get("profilePic").toString())),
              // ),
              // child: Text(snapshot.data!.docs[index].get("fullName"), style: TextStyle(),textAlign: TextAlign.center,),
        ),
          );
        //:Text("data",style: TextStyle(color: Colors.white),);
        //:Container();
      },
    );
  }



}


