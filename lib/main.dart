
import 'package:flutter/material.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/views_students/questionWidget.dart';
import 'package:my_project/views/views_teachers/add_quizs.dart';
import 'package:my_project/views/views_teachers/showListname.dart';


void main() async {
  
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
      home: QuestionWidget()
    );
  }
}
  