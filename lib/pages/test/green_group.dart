import 'package:flutter/material.dart';
import 'package:messenger/helper/global.dart';
import 'package:messenger/pages/test/white_group.dart';
import 'package:messenger/widgets/widgets.dart';

class GreenPage extends StatefulWidget {
  const GreenPage({Key? key}) : super(key: key);

  @override
  State<GreenPage> createState() => _GreenPageState();
}

class _GreenPageState extends State<GreenPage> {

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
  "веселы и жизнерадостны",
  "энергичны и деловиты",
   'часто не доводите начатое дело до конца',
   'склонны переоценивать себя',
   'способны быстро схватывать новое',
   'неустойчивы в интересах и склонностях',
   'легко переживаете неудачи и неприятности',
   'легко приспосабливаетесь к разным обстоятельствам',
   'с увлечением беретесь за любое новое дело',
   'быстро остываете, если дело перестает вас интересовать',
   'быстро включаетесь в новую работу и быстро переключаетесь с одной работы на другую',
  'тяготитесь однообразием будничной кропотливой работы',
   'общительны и отзывчивы, не чувствуете скованности с новыми для вас людьми',
   'выносливы и работоспособны',

   'обладаете громкой, быстрой, отчетливой речью, сопровождающейся жестами, выразительной мимикой',
   'сохраняете самообладание в неожиданной сложной обстановке',
   'обладаете всегда бодрым настроением',
   'быстро засыпаете и пробуждаетесь',
'часто не собраны, проявляете поспешность в решениях',
 'склонны иногда скользить по поверхности, отвлекаться'
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
              height: 1200,

              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Container(
                  height: 1000,
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
                    GreenGroup=counter;
                  });
                  nextScreen(context, WhitePage());
                  }, child: Text("Дальше"))
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


