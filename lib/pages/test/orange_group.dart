import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/pages/home_page.dart';
import 'package:messenger/pages/profile_page.dart';
import 'package:messenger/widgets/widgets.dart';

import '../../helper/global.dart';

class OrangePage extends StatefulWidget {
  const OrangePage({Key? key}) : super(key: key);

  @override
  State<OrangePage> createState() => _OrangePageState();
}

class _OrangePageState extends State<OrangePage> {

  int counter=0;

  final List<Color> colors = <Color>[
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  final List<String> questions=[
    "стеснительны и застенчивы",
    "теряетесь в новой обстановке",
    'затрудняетесь установить контакт с незнакомыми людьми',
    'не верите в свои силы',
    'легко переносите одиночество',
    'чувствуете подавленность и растерянность при неудачах',
    'склонны уходить в себя',
    'быстро утомляетесь',
    'обладаете тихой речью',
    ' невольно приспосабливаетесь к характеру собеседника',
    'впечатлительны до слезливости',
    'чрезвычайно восприимчивы к одобрению и порицанию',
    'предъявляете высокие требования к себе и окружающим',
    'склонны к подозрительности, мнительности',

    'болезненно чувствительны и легко ранимы',
    'чрезмерно обидчивы',
    'скрытны и необщительны, не делитесь ни с кем своими мыслями',
    'малоактивны и робки',
    'уступчивы, покорны',
    'стремитесь вызвать сочувствие и помощь у окружающих'
  ];

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
          backgroundColor: Colors.transparent,
            appBar: AppBar(title: Text("Tecт",),),
            body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: 800,
                  height: 1300,

                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Container(
                        height: 1160,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: colors.length,
                            itemBuilder: (_, int index){

                              return QuestionBuilder(index);
                            }
                        ),
                      ),
                      SizedBox(height: 30,),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          OrangeGroup=counter;
                        });
                        int max=0;
                        int max2=0;
                        if(RedGroup>max){
                          max=RedGroup;
                        }
                        if(GreenGroup>max){
                          max=GreenGroup;
                        }
                        if(WhiteGroup>max){
                          max=WhiteGroup;
                        }
                        if(OrangeGroup>max){
                          max=OrangeGroup;
                        }

                        if(RedGroup>max2 && RedGroup!=max){
                          max2=RedGroup;
                        }
                        if(GreenGroup>max2 && GreenGroup!=max){
                          max2=GreenGroup;
                        }
                        if(WhiteGroup>max2 && WhiteGroup!=max){
                          max2=WhiteGroup;
                        }
                        if(OrangeGroup>max2 && OrangePage!=max){
                          max2=OrangeGroup;
                        }
                        print(FirebaseAuth.instance.currentUser!.uid);
                        print(RedGroup+WhiteGroup+OrangeGroup+GreenGroup);
                        if(max==RedGroup){
                          if(max2==GreenGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"красно-зелёная"});
                            Group="красно-зелёная";
                          }
                          if(max2==WhiteGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"красно-белая"});
                            Group="красно-белая";
                          }
                          if(max2==OrangeGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"красно-оранжевая"});
                            Group="красно-оранжевая";
                          }
                        }
                        if(max==GreenGroup){
                          if(max2==RedGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"зелёно-красная"});
                            Group="зелёно-красная";
                          }
                          if(max2==WhiteGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"зелёно-белая"});
                            Group="зелёно-белая";
                          }
                          if(max2==OrangeGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"зелёно-оранжевая"});
                            Group="зелёно-оранжевая";
                          }
                        }
                        if(max==WhiteGroup){
                          if(max2==GreenGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"бело-зелёная"});
                            Group="бело-зелёная";
                          }
                          if(max2==RedGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"бело-красная"});
                            Group="бело-красная";
                          }
                          if(max2==OrangeGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"бело-оранжевая"});
                            Group="бело-оранжевая";
                          }
                        }
                        if(max==OrangeGroup){
                          if(max2==GreenGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"оранжево-зелёная"});
                            Group="оранжево-зелёная";
                          }
                          if(max2==WhiteGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"оранжево-белая"});
                            Group="оранжево-белая";
                          }
                          if(max2==RedGroup){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                {"группа":"оранжево-красная"});
                            Group="оранжево-красная";
                          }

                        }
                        nextScreen(context, ProfilePage(
                            email: FirebaseAuth.instance.currentUser!.email.toString(),
                            userName: FirebaseAuth.instance.currentUser!.displayName.toString(),
                            about: GlobalAbout.toString(),
                            age: GlobalAge.toString(),
                            deti: GlobalDeti,
                            rost: GlobalRost.toString(),
                            city: GlobalCity.toString(),
                            hobbi: GlobalHobbi.toString(),
                            pol: GlobalPol.toString(),
                        ));
                        showSnackbar(context, Colors.green, "Успешно! Ваша группа: $Group}");
                        }, child: Text("Завершить"))
                    ],
                  ),
                )
            )
        ),
      ],
    );
  }
  QuestionBuilder(int index){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 230,child: Text(questions[index],style: TextStyle(color: Colors.white))),
            Row(
              children: [
                ElevatedButton(

                  onPressed: (){
                    setState(() {

                      colors[index]=Colors.green;
                      counter++;

                    });
                  }, child: Text("+",style: TextStyle(fontSize: 25),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colors[index]==Colors.red?Colors.grey:colors[index]
                  ),

                ),
                SizedBox(width: 10,),
                ElevatedButton(

                  onPressed: (){
                    if(counter!=0){
                      setState(() {
                        counter--;
                      });
                    }
                    setState(() {
                      colors[index]=Colors.red;
                    });
                  }, child: Text("-",style: TextStyle(fontSize: 25),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colors[index]==Colors.green?Colors.grey:colors[index]
                  ),

                ),
              ],
            ),

          ],
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}


