import 'package:flutter/material.dart';
import 'package:messenger/helper/global.dart';
import 'package:messenger/pages/test/orange_group.dart';
import 'package:messenger/widgets/widgets.dart';

class WhitePage extends StatefulWidget {
  const WhitePage({Key? key}) : super(key: key);

  @override
  State<WhitePage> createState() => _WhitePageState();
}

class _WhitePageState extends State<WhitePage> {

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
    "спокойны и хладнокровны",
    "последовательны и обстоятельны в делах",
    'осторожны и рассудительны',
    'умеете ждать',
    'молчаливы и не любите попусту болтать',
    'обладаете спокойной, равномерной речью, с остановками, без резко выраженных эмоций, жестикуляции и мимики',
    'сдержаны и терпеливы',
    'доводите начатое дело до конца',
    'не растрачиваете попусту сил',
    'придерживаетесь выработанного распорядка дня, жизни, системы в работе',
    'легко сдерживаете порывы',
    'маловосприимчивы к одобрению и порицанию',
    'незлобивы, проявляете снисходительное отношение к колкостям в свой адрес',
    'постоянны в своих отношениях и интересах',

    'медленно включаетесь в работу и медленно переключаетесь с одного дела на другое',
    'ровны в отношениях со всеми',
    'любите аккуратность и порядок во всем',
    'с трудом приспосабливаетесь к новой обстановке',
    'обладаете выдержкой',
    'несколько медлительны'
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
                  height: 1160,

                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Container(
                        height: 1020,
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
                          WhiteGroup=counter;
                        });
                        nextScreen(context, OrangePage());
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


