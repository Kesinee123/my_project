import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_project/views/first_page.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/views_students/quizPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB09RD4a1DPfk0S_IAgsVCC4MAXQbqBow0",
      appId: "1:506605725552:web:32fd1b1a28978e7c54d1b5",
      messagingSenderId: "506605725552",
      projectId: "quiz-project-dd8f7"));
  }else{
    await Firebase.initializeApp(); 
  }

  final PendingDynamicLinkData? initiaLink = 
    await FirebaseDynamicLinks.instance.getInitialLink();
  
  runApp(MyApp(
    initiaLink: initiaLink,
    ));
}

class MyApp extends StatefulWidget {
  final PendingDynamicLinkData? initiaLink;
  const MyApp({Key? key, this.initiaLink}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String? path;

  @override
  void initState() {
    if (widget.initiaLink != null) {
      path = widget.initiaLink!.link.path;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      // ignore: prefer_const_constructors
      // home: firstPage(path: path.toString(),),
      home: QuizPage(quizId: 'R7wN0dwEbTVDqba8BMfx'),
      // onGenerateRoute: RouteServices.generateRoute
    );
  }
}
