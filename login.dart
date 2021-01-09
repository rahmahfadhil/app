import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appabsencess/section.dart';
import 'package:flutter_appabsencess/stages.dart';
import 'package:flutter_appabsencess/thestages.dart';
import 'package:http/http.dart' as ht;


TextEditingController emailControl = TextEditingController();
TextEditingController passwordControl = TextEditingController();
String str1="Email" ;
String str2="password";


class Login extends StatefulWidget {

  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: Stack(
          children: [
      Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('image/images.jpg'), fit: BoxFit.fill)),
    ),
    Column(
    children: [
    Padding(
    padding: const EdgeInsets.fromLTRB(30, 100, 0, 0),
    child: Container(

    child: Text(
    'Sign in',
    style: TextStyle(color: Colors.white, fontSize: 70),
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
    child: Container(
    child: Text(
    'enter your email please',
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    ),
    ),

    ],
    ),
    Padding(
    padding: const EdgeInsets.fromLTRB(30, 300, 100, 0),
    child: Container(
    width: MediaQuery.of(context).size.width,
    color: Colors.white54,
    child: Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
    child: StatefulBuilder(
    builder: (context, setstate) {
    return TextField(
    controller: emailControl,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
    hintText:"Email",
    hintStyle: TextStyle(
    color: Colors.white,
    ),
    icon: Icon(
    Icons.email,
    ),
    ),
    );
    },
    ),
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.fromLTRB(30, 400, 100, 0),
    child: Container(
    width: MediaQuery.of(context).size.width,
    color: Colors.white54,
    child: Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
    child: StatefulBuilder(
    builder: (context, setstate) {
    return TextField(
    controller: passwordControl,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
    hintText: "Password",
    hintStyle: TextStyle(
    color: Colors.white,
    ),
    icon: Icon(
    Icons.vpn_key_rounded,
    ),
    ),
    obscureText: true,
    );
    },
    )),
    ),
    ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 500, 25, 0),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 300,
                    child: Material(
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.red,
                      color: Colors.red,
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            str1 = emailControl.text;
                            str2 = passwordControl.text;
                          });
                          String url = 'https://vardevs.com/college/login.php';
                          Map map = {
                            "email": "${str1}",
                            "password": "${str2}",
                          };
                          ht.Response response = await ht.post(url, body: map);
                          String str = utf8.decode(response.bodyBytes);
                          List list = jsonDecode(str);

                          if (response.body.trim() != "0") {
                            print('response status:${response.statusCode}');
                            print('response status:${response.body}');
                            print(list);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return TheStages(list: initTables(list));
                            }));
                          }





                        },
                        child: Center(
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'forget your password?',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
      ),
    );
  }
}


initTables(List json) {
  List<Section> list = List();
  json.forEach((element) {
    list.add(Section(element));
  });
  return list;
}