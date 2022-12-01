import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuestionQuiz extends StatefulWidget {
  const QuestionQuiz({super.key, required this.quizId, required this.questionId, required this.question});

  final String quizId;
  final String questionId;
  final String question;

  @override
  State<QuestionQuiz> createState() => _QuestionQuizState();
}

class _QuestionQuizState extends State<QuestionQuiz> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        child: ListTile(
          title: Column(
            children: [
              Text(widget.questionId),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('โจทย์แบบทดสอบ : '),
                  SizedBox(width: 10,),
                  Text(widget.question),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('คำตอบ : '),
                  SizedBox(width: 10,),
                  Text('1'),
                ],
              )
            ],
          ) ,
          subtitle: Text(widget.quizId) ,
        ),
      ),
    );
  }
}