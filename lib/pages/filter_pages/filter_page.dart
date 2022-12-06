import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);



  @override


  State<FilterPage> createState() => _FilterPageState();


}

class _FilterPageState extends State<FilterPage> {

  String pol="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Фильтр"),
        //actions: [IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(CupertinoIcons.clear)),],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          height: 500,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          constraints: const BoxConstraints(
              maxHeight: 400, minHeight: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(context: context, builder: (context){
                        return
                          Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(

                            ),
                            body: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              child: Column (
                                children: [
                                  GestureDetector(
                                    child: Row(
                                      children: const [
                                        Text("Мужчины"),
                                        Icon(Icons.man)
                                      ],
                                    ),
                                    onTap: (){
                                      setState(() {
                                        pol="m";
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(height: 15,),
                                  GestureDetector(
                                    child: Row(
                                      children: const[
                                        Text("Женщины"),
                                        Icon(Icons.woman)
                                      ],
                                    ),
                                    onTap: (){
                                      setState(() {
                                        pol="zh";
                                      });
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            ),

                          );
                      });
                    },
                    child: Container(

                      width: MediaQuery.of(context).size.width-20,
                      padding:const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(CupertinoIcons.person),
                              const SizedBox(width: 10,),
                              const Text("Пол:"),
                              const SizedBox(width: 10,),
                              Text(pol=="m"? "Мужчины" : "Женщины")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const[
                              Icon(CupertinoIcons.calendar),
                              SizedBox(width: 10,),
                              Text("Возраст:"),
                              SizedBox(width: 10,),
                              Text("18-22")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const[
                              Icon(CupertinoIcons.map),
                              SizedBox(width: 10,),
                              Text("Город:"),
                              SizedBox(width: 10,),
                              Text("Чебоксары")
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
