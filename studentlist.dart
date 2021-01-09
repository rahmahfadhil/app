import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as ht;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


import 'name.dart';


class StudentList extends StatefulWidget {
  List<names1> list;
  List<bool> listOfcheck = List();
  List<String> listofid = List();

  String id;
  StudentList({this.list, this.id});
// StudentList({this.list2});
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  bool checkbox = true;
  DateTime _dateTime;
  String date = DateTime.now().toString();

  TimeOfDay time;
  TimeOfDay picked;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
  }

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: time);
    if (picked != null) {
      setState(() {
        time = picked;
      });
    }
  }

  Widget build(BuildContext context) {
    String thedate;
    for (int i = 0; i < widget.list.length; i++) {
      widget.listOfcheck.add(true);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: Text("Software Engineering"),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
              elevation: 5,
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        lastDate: DateTime(2022),
                      ).then((value) {
                        setState(() {
                          _dateTime = value;
                          String time = _dateTime.toString();
                          thedate = time.toString();
                          date = time.substring(0, 10);
                        });
                      });
                    },
                  ),
                  subtitle: Text("${time.hour}:${time.minute}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
                  trailing: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () {
                      selectTime(context);
                    },
                  ),
                  title: Text(
                    "${date.substring(0, 10)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height /1.7,
                child: ListView.builder(
                    itemCount: widget.list.length,
                    itemBuilder: (context, i) {
                      return Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    child: Center(
                                      child: ListTile(
                                        trailing: Text("_${widget.list[i].id}"),
                                        leading: Checkbox(
                                            value: widget.listOfcheck[i],
                                            onChanged: (bool value) {
                                              setState(() {
                                                if (widget.listOfcheck[i]) {
                                                  widget.listofid
                                                      .add(widget.list[i].id);
                                                }

                                                widget.listOfcheck[i] =
                                                    !widget.listOfcheck[i];
                                              });
                                            }),
                                        title: Center(
                                            child: Text(widget.list[i].name)),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: SizedBox(
              height: MediaQuery.of(context).size.height / 17,
              width: MediaQuery.of(context).size.width / 4,
              child: RaisedButton(
                onPressed: () async {
                  var url = 'https://vardevs.com/college/add_absences.php';
                  Map map = Map();
                  for (int i = 0; i < widget.listofid.length; i++) {
                    map['id_student'] = widget.listofid[i];
                    map['date'] = date.substring(0, 10);
                    map['id_teacher'] = "1";
                    map['id_section'] = "1";
                    print(widget.listofid);
                    print(map);
                    Response response = await post(url, body: map);
                  }
                },
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Color(0xFF728FCE),
                elevation: 5,
                splashColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            )),
          ),
        ]));
  }
}

class MultipleNotifier extends ChangeNotifier {
  List<String> _selecteditems;
  MultipleNotifier(this._selecteditems);
  List<String> get selectitems => _selecteditems;
  bool isHaveitem(String value) => _selecteditems.contains(value);
  addItem(String value) {
    if (!isHaveitem(value)) {
      _selecteditems.add(value);
      notifyListeners();
    }
  }

  removeItem(String value) {
    if (isHaveitem(value)) {
      _selecteditems.remove(value);
      notifyListeners();
    }
  }
}
