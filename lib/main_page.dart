import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/views_students/codePage.dart';
import 'package:my_project/views/views_students/homeStudent.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/profile_user.dart';
import 'package:email_validator/email_validator.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("user").doc(snapshot.data!.uid).snapshots(),
              builder:(BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){ 
                  final user = snapshot.data.data();
                  RegExp emailTeacher = RegExp(r'[A-Za-z0-9]+@gmail+.com');
                  RegExp emailStudent = RegExp(r'[0-9]+@dpu+.ac.th');
                  if(emailTeacher.hasMatch(user['email'])){
                    return HomePage();
                    // print(email);
                  } else {
                    return StudentPage();
                    // print(email);
                  }
                }return Material(child: Center(
                  child: CircularProgressIndicator(),
                ),);
              },);
            // return HomePage();
          }else{
            return SignIn();
          }
        }),
    );
  }
}