import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appabsencess/section.dart';
import 'package:flutter_appabsencess/stages.dart';
import 'package:flutter_appabsencess/thedivision.dart';
import 'package:http/http.dart' as https;

import 'division.dart';

class TheStages extends StatefulWidget {
  List<Section>list;
  TheStages({this.list});

  @override
  _TheStagesState createState() => _TheStagesState();
}

class _TheStagesState extends State<TheStages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text('Sowftware Engineer',
            style: TextStyle(color: Colors.white, fontSize: 25.0)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              width:MediaQuery.of(context).size.width/2,
              height:MediaQuery.of(context).size.height/4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white70,
                image: const DecorationImage(
                  image:AssetImage('image/flutter.png'),
                  fit: BoxFit.cover,
                ),

                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Center(child: Text('choose the stage',style: TextStyle(fontSize: 40.0,),)),
          Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width/1.5,
            alignment: Alignment.center,
            child:ListView.builder(itemCount: widget.list.length,itemBuilder: (context, index) {
            return Padding(padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: ()async{
                String url='https://vardevs.com/college/get_section.php';
                Map map={
                  'id':'${widget.list[index].id_stage}',
                };
                https.Response response=await https.post(url,body: map);
               if (response.body.trim()!='0'){
                String str=utf8.decode(response.bodyBytes);
                List json=jsonDecode(str);
                List <Division> list=List();
                json.forEach((element) {
                  list.add(Division(element));
                });
                print(list);
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return TheDivision(list: list)   ;
                }));
               }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(12.0) ),
                  color: Colors.white70,
                  elevation: 5,
                  child: ListTile(
                    title: Center(child: Text(widget.list[index].stage)),
                  ),

                ),
              ),
            ),


            );
            },) ,

          )
        ],
      ),
    );
  }
}
