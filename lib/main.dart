import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_project/main_page.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/signup.dart';
import 'package:my_project/views/views_students/codePage.dart';
import 'package:my_project/views/views_students/namePage.dart';
import 'package:my_project/views/views_students/questionWidget.dart';
import 'package:my_project/views/views_teachers/add_quizs.dart';
import 'package:my_project/views/views_teachers/profile_user.dart';
import 'package:my_project/views/views_teachers/showListname.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage()
    );
  }
}