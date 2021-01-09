import 'package:flutter/material.dart';
import 'package:flutter_appabsencess/division.dart';
import 'package:flutter_appabsencess/stages.dart';
import 'package:flutter_appabsencess/thechooses.dart';
class TheDivision extends StatefulWidget {
  List<Division>list;
  List<Stage> id_teacher;
  TheDivision({this.list});
  @override
  _TheDivisionState createState() => _TheDivisionState();
}

class _TheDivisionState extends State<TheDivision> {
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
                  image: AssetImage('image/flutter.png'),
                  fit: BoxFit.cover,
                ),

                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Center(child: Text('choose the Division',style: TextStyle(fontSize: 40.0,),)),
          Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width/1.5,
            alignment: Alignment.center,
            child:ListView.builder(itemCount: widget.list.length,itemBuilder: (context, index) {
              return Padding(padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return Choose(id:widget.list[index].id)   ;

                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(12.0) ),
                      color: Colors.white70,
                      elevation: 5,
                      child: ListTile(
                        title: Center(child: Text(widget.list[index].section)),
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
