import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;

import 'dates.dart';
import 'listofabsencess.dart';
import 'listofname.dart';

class DateOfAbsStud extends StatefulWidget {

  List<Date> list;

  DateOfAbsStud({this.list});

  @override
  _DateOfAbsStudState createState() => _DateOfAbsStudState();
}
class _DateOfAbsStudState extends State<DateOfAbsStud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("Software Engineering"),
      ),
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: ()async{
                var url = 'https://vardevs.com/college/get_absences.php';

                Map map={
                  "date":"${widget.list[i].date}",
                  "id_teacher":"${1}",
                  "id_section":"${1}"
                };
                https.Response response = await https.post(url,body: map);
                if (response.body.trim()!='0') {

                  String str = utf8.decode(response.bodyBytes);
                  List json1 = jsonDecode(str);
                  List <Listname>list1 = List();
                  json1.forEach((element) {
                    list1.add(Listname(element));
                  }
                  );

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return NameOfAbsStud(list: list1);
                      }
                      ));
                }
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 5,
                  child:ListTile(
                    title: Center(child: Text(widget.list[i].date,style: TextStyle(color: Colors.black, fontSize: 20),)),
                  )
              ),
            ),
          );

        },
      ),
    );
  }
}
