import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/AddQuiz.dart';
import 'package:my_project/views/CreateQuestion.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple),
      body: Container(
        alignment: Alignment.topRight,
        child: ElevatedButton.icon(
          onPressed: (() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuiz() ,) );
          }), icon: Icon(Icons.add), 
          label: Text("New Question"),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange
          ),
          ) ),
    );
  }
}
