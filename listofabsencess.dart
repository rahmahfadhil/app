import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;

import 'listofname.dart';

class NameOfAbsStud extends StatefulWidget {
  List<Listname> list;
  NameOfAbsStud({this.list});

  @override
  _NameOfAbsStudState createState() => _NameOfAbsStudState();
}

class _NameOfAbsStudState extends State<NameOfAbsStud> {
  String change="Edit";
  bool delet=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("Software Engineering"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/1.5,
            child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, i) {
                return Center(

                  child: Column(

                    children: [
                      // list of  Absences student
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          key: Key(widget.list[i].id),
                          onTap: (){

                          },
                          child: Card(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            elevation: 5,
                            child:ListTile(
                              leading:Text("${widget.list[i].id}",style: TextStyle(color: Colors.black, fontSize: 20),),
                              title: Text(widget.list[i].name,style: TextStyle(color: Colors.black, fontSize: 20),),
                              trailing:Visibility(
                                  visible: delet,
                                  child: GestureDetector(
                                      onTap: ()async{

                                        var url = 'https://vardevs.com/college/DELETE_absences.php';
                                        Map map={
                                          "id_absences":"${widget.list[i].id}",
                                        };
                                        https.Response response = await https.post(url,body: map);
                                        if (response.body.trim()!='0') {
                                          setState(() {
                                            widget.list.removeAt(i);
                                          }
                                          );
                                        }
                                      },
                                      child: Icon(Icons.remove_circle,color: Colors.red,

                                      )
                                  )
                              ),

                            ),
                          ),
                        ),
                      )],
                  ),
                );
              },
            ),
          ),



          RaisedButton(onPressed: (){

            setState(() {
              change="Submit";
              delet=true;
            });},
            child:Text(change),
            splashColor: Colors.red,

          ),
        ],
      ),


    );
  }
}
