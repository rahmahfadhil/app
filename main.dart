import 'package:flutter/material.dart' show MaterialApp, runApp;
import 'package:flutter_appabsencess/thestages.dart';
import 'dart:convert';
import 'login.dart';

void main() {

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login()
  ));
}