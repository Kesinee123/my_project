import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/views_teachers/create_questions.dart';
import 'package:my_project/views/views_teachers/create_questions2.dart';
import 'package:my_project/views/views_teachers/create_questions3.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key, required this.quizId, required this.questionId});

  final String quizId;
  final String questionId;

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.deepPurple,
      // ),
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              ),
              SizedBox(height: 20,),
              Center(
               child: Container(
                color: Colors.white,
                height: 500,
                width: 500,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Center(
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(100, 70),
                                  backgroundColor: Colors.yellowAccent
                                ),
                                onPressed: (() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuestion(quizId: widget.quizId, questionId: widget.questionId ,) ,) );
                                }),
                                 child: Icon(Icons.check_circle_outline, color: Colors.black,size: 50,)
                                 
                              ),
                            ],
                          ) ,
                          ),
                          Center(
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: 
                              Text("(เลือกได้ 1 ข้อ)",style: TextStyle(fontWeight: FontWeight.bold),)
                          ) ,
                          ),
                       ],
                     ),
                   ),
                   SizedBox(height: 20,),
                   Container(
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Center(
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(100, 70),
                                  backgroundColor: Colors.yellowAccent
                                ),
                                onPressed: (() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuestion2(quizId: widget.quizId, questionId: widget.questionId,) ,) );
                                }),
                                 child: Icon(Icons.checklist_outlined, color: Colors.black,size: 50,)
                              ),
                            ],
                          ) ,
                          ),
                          Center(
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: 
                              Text("(เลือกได้มากกว่า 1 ข้อ)",style: TextStyle(fontWeight: FontWeight.bold),)
                          ) ,
                          ),
                       ],
                     ),
                   ),
                   SizedBox(height: 20,),
                   Container(
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Center(
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(100, 70),
                                  backgroundColor: Colors.yellowAccent
                                ),
                                onPressed: (() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuestion3(quizId: widget.quizId, questionId: widget.questionId,) ,) );
                                }),
                                 child: Icon(Icons.create_rounded,color: Colors.black,size: 50,)
                              ),
                             
                            ],
                          ) ,
                          ),
                          Center(
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: 
                              Text("(ข้อเขียน)",style: TextStyle(fontWeight: FontWeight.bold))
                          ) ,
                          ),
                       ],
                     ),
                   ),
                 ],
               ),
                      
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
