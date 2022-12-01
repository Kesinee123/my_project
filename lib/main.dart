import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_project/main_page.dart';
import 'package:my_project/views/signin.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyB09RD4a1DPfk0S_IAgsVCC4MAXQbqBow0",
      appId: "1:506605725552:web:32fd1b1a28978e7c54d1b5",
      messagingSenderId: "506605725552",
      projectId: "quiz-project-dd8f7"));
  }else{
    await Firebase.initializeApp(); 
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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