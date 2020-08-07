import 'package:firebasedemo/ui/view/authentication/login_view.dart';
import 'package:firebasedemo/ui/view/home/fire_home_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoginView(),
    );
  }
}
