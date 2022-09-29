import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/models/quiz.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:my_project/views/homepage.dart';
import 'package:my_project/views/AddQuiz.dart';
import 'package:random_string/random_string.dart';


class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  Quiz myquiz = Quiz(quizImageUrl: 'quizImageUrl',quizSubject: 'quizSubject',quizTitle: 'quizTitle');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _quizCollection = FirebaseFirestore.instance.collection("Quizs");

  @override
  Widget build(BuildContext context) { 
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("error"),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
             return Scaffold(
          appBar: AppBar(backgroundColor: Colors.purpleAccent),
          body: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(children: [
                TextFormField(
                  validator: ((val) => val!.isEmpty ? "Enter Image Url" : null),
                  decoration: InputDecoration(hintText: "Quiz Image"),
                  onSaved: ((val) {
                    myquiz.quizImageUrl = val!;
                  }),
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: ((val) =>
                      val!.isEmpty ? "Enter Quiz Title" : null),
                  decoration: InputDecoration(hintText: "Quiz Title"),
                  onSaved: ((val) {
                    myquiz.quizTitle = val!;
                  }),
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: ((val) => val!.isEmpty ? "Enter Subject" : null),
                  decoration: InputDecoration(hintText: "Quiz subject"),
                  onSaved: ((val) {
                    myquiz.quizSubject = val!;
                  }),
                ),
                Spacer(),
              ]),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: ()  {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                  _quizCollection.add({
                  "quizImageUrl": myquiz.quizImageUrl,
                  "quizTitle": myquiz.quizTitle,
                  "quizSubject": myquiz.quizSubject,
                });
                _formKey.currentState!.reset();
                // Navigator.pushReplacement(context, MaterialPageRoute(
                //   builder: (context) => HomePage()
                  
                //    ));
              }
            },
            label: const Text('Create Qusetion'),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.purpleAccent,
          ),
        );
      }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
