
import 'package:flutter/material.dart';

import 'package:my_project/compornent/formCreateQuiz.dart';


class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Quiz"),
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(50),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Expanded(
                      child: Column(
                        children: [
                          FormCreateQuiz(),
                        ],
                      ))
              )
            )
          ),
        )
    );
                       
                 
          
  }
}

