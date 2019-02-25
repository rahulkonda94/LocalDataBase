import 'package:flutter/material.dart';
import './screens/login/LoginPage.dart';
import './screens/signUp/SignUpPage.dart';


void main() => runApp(MyApp());

final Map<String, WidgetBuilder> routes = {
  '/login'  : (BuildContext context) => LoginPage(),
  '/signup': (BuildContext context) =>  SignUpPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 1',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}

