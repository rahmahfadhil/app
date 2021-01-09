import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appabsencess/date.dart';
import 'package:flutter_appabsencess/division.dart';
import 'package:flutter_appabsencess/studentlist.dart';
import 'package:http/http.dart' as ht;

import 'dates.dart';
import 'name.dart';

class Choose extends StatefulWidget {
  String id = '1';

  Choose({this.id});
  @override
  // String id = "1";

  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
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
            itemCount: 1,
            itemBuilder: (context, i) {
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 30, 50, 50),
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              image: DecorationImage(
                                  image: AssetImage('image/flutter.png'),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        padding: EdgeInsets.all(0.0),
                        width: 250,
                        height: 60,
                        child: Center(
                            child: (Text(
                          "Choose :",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ))),
                        alignment: Alignment.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        elevation: 5,
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: 250,
                            height: 60,
                            child: GestureDetector(
                              onTap: () async {
                                var url =
                                    'https://vardevs.com/college/get_students.php';
                                Map map = {"id": "3"};
                                ht.Response response =
                                    await ht.post(url, body: map);
                                String str = utf8.decode(response.bodyBytes);
                                List json = jsonDecode(str);
//print(" ressss ${response.bodyBytes}");
                                print(json);
                                List<names1> list = List();
                                json.forEach((element) {
                                  list.add(names1(element));
                                });
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return StudentList(
                                    list: list,
                                  );
                                }));
                              },
                              child: Text("Lists"),
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 1.0,
                                    spreadRadius: 3.0,
                                  )
                                ])),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            var url =
                                'https://vardevs.com/college/get_date.php';
                            Map map = {
                              "id_teacher": "${1}",
                              "id_section": "${1}"
                            };
                            ht.Response response =
                                await ht.post(url, body: map);
                            if (response.body.trim() != '0') {
                              String str = utf8.decode(response.bodyBytes);
                              List json = jsonDecode(str);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');
                              // print(list);
                              List<Date> list = List();
                              json.forEach((element) {
                                list.add(Date(element));
                              });
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return DateOfAbsStud(
                                  list: list,
                                );
                              }));
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            elevation: 5,
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                width: 280,
                                height: 60,
                                alignment: Alignment.center,
                                child: Text(
                                  " Absences List",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 1.0,
                                        spreadRadius: 3.0,
                                      )
                                    ])),
                          ),
                        ))
                  ],
                ),
              );
            }));
  }
}
