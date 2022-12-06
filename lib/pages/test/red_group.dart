import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:messenger/helper/global.dart';
import 'package:messenger/pages/test/green_group.dart';

import '../../widgets/widgets.dart';

class FirstGroupRed extends StatefulWidget {
  const FirstGroupRed({Key? key}) : super(key: key);

  @override
  State<FirstGroupRed> createState() => _FirstGroupRedState();
}

class _FirstGroupRedState extends State<FirstGroupRed> {

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

  int counter=0;
  @override


  Widget build(BuildContext context) {




    return Container(
      child: Stack(
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
              child: Container(
                width: 800,
                height: 1200,

                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(

                  children: [
                    Text("Отметьте знаком «+» те качества , которые для вас обычны и «-» если противоположны, повседневны. Итак, если вы:",style: TextStyle(fontSize: 16,color: Colors.white),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("неусидчивы, суетливы",style: TextStyle(color: Colors.white),),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[0]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25,color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[0]==Colors.red?Colors.grey:colors[0]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[0]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[0]==Colors.green?Colors.grey:colors[0]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("невыдержанны, вспыльчивы;",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[1]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[1]==Colors.red?Colors.grey:colors[1]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[1]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[1]==Colors.green?Colors.grey:colors[1]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("нетерпеливы",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[2]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[2]==Colors.red?Colors.grey:colors[2]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[2]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[2]==Colors.green?Colors.grey:colors[2]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 200,child: Text("резки и прямолинейны в отношениях с людьми",style: TextStyle(color: Colors.white))),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[3]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[3]==Colors.red?Colors.grey:colors[3]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[3]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[3]==Colors.green?Colors.grey:colors[3]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("решительны и инициативны",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[4]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[4]==Colors.red?Colors.grey:colors[4]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[4]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[4]==Colors.green?Colors.grey:colors[4]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("упрямы",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[5]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[5]==Colors.red?Colors.grey:colors[5]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[5]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[5]==Colors.green?Colors.grey:colors[5]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("находчивы в споре",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[6]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[6]==Colors.red?Colors.grey:colors[6]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[6]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[6]==Colors.green?Colors.grey:colors[6]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("работаете рывками",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[7]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[7]==Colors.red?Colors.grey:colors[7]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[7]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[7]==Colors.green?Colors.grey:colors[7]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("склонны к риску",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[8]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[8]==Colors.red?Colors.grey:colors[8]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[8]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[8]==Colors.green?Colors.grey:colors[8]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("злопамятны",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[9]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[9]==Colors.red?Colors.grey:colors[9]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[9]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[9]==Colors.green?Colors.grey:colors[9]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 200,child:Text("обладаете быстрой, страстной, со сбивчивыми интонациями речью",style: TextStyle(color: Colors.white))),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[10]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[10]==Colors.red?Colors.grey:colors[10]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[10]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[10]==Colors.green?Colors.grey:colors[10]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 200,child:Text("неуравновешенны и склонны к горячности",style: TextStyle(color: Colors.white))),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[11]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[11]==Colors.red?Colors.grey:colors[11]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[11]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[11]==Colors.green?Colors.grey:colors[11]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("агрессивный забияка",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[12]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[12]==Colors.red?Colors.grey:colors[12]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[12]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[12]==Colors.green?Colors.grey:colors[12]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("нетерпимы к недостаткам",style: TextStyle(color: Colors.white)),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[13]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[13]==Colors.red?Colors.grey:colors[13]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[13]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[13]==Colors.green?Colors.grey:colors[13]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 200,child:Text("обладаете выразительной мимикой",style: TextStyle(color: Colors.white))),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[14]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[14]==Colors.red?Colors.grey:colors[14]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[14]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[14]==Colors.green?Colors.grey:colors[14]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 200,child:Text("способны быстро действовать и решать",style: TextStyle(color: Colors.white))),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[15]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[15]==Colors.red?Colors.grey:colors[15]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[15]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[15]==Colors.green?Colors.grey:colors[15]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 200,child:Text("неустанно стремитесь к новому",style: TextStyle(color: Colors.white))),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[16]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[16]==Colors.red?Colors.grey:colors[16]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[16]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[16]==Colors.green?Colors.grey:colors[16]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 200,child:Text("обладаете резкими порывистыми движениями",style: TextStyle(color: Colors.white))),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[17]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[17]==Colors.red?Colors.grey:colors[17]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[17]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[17]==Colors.green?Colors.grey:colors[17]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 200,child:Text("настойчивы в достижении поставленной цели",style: TextStyle(color: Colors.white))),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[18]=Colors.green;
                                  counter++;

                                });
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[18]==Colors.red?Colors.grey:colors[18]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[18]=Colors.red;
                                });
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[18]==Colors.green?Colors.grey:colors[18]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 200,child:Text("склонны к резким сменам настроения",style: TextStyle(color: Colors.white))),
                        Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){
                                setState(() {

                                  colors[19]=Colors.green;
                                  counter++;


                                });
                                print(counter);
                              }, child: Text("+",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[19]==Colors.red?Colors.grey:colors[19]
                              ),

                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(

                              onPressed: (){
                                setState(() {
                                  colors[19]=Colors.red;
                                });
                                print(counter);
                              }, child: Text("-",style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colors[19]==Colors.green?Colors.grey:colors[19]
                              ),

                            ),
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        RedGroup=counter;
                      });
                      nextScreen(context, GreenPage());
                    }, child: Text("Дальше"),)

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
