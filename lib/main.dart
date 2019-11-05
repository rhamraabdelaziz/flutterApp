import 'package:flutter/material.dart';
import './pages/login1.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red,
    ),
    home: Login(),
  ));
}
