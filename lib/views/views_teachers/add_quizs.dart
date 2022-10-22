import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/views_teachers/create_questions.dart';
import 'package:my_project/views/views_teachers/create_questions2.dart';
import 'package:my_project/views/views_teachers/create_questions3.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple),
      backgroundColor: Colors.deepPurple,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Add Question",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            Container(
             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
             height: MediaQuery.of(context).size.height * 0.60,
             child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12 ),
             ),
             elevation: 8,
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
                                backgroundColor: Colors.deepPurple
                              ),
                              onPressed: (() {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuestion() ,) );
                              }),
                               child: Image.asset("assets/circle-dot.png",height: 60,width: 50,),
                               
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
                 Container(
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple
                              ),
                              onPressed: (() {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuestion2() ,) );
                              }),
                               child: Image.asset("assets/check.png",height: 60,width: 50,),
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
                 Container(
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple
                              ),
                              onPressed: (() {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuestion3() ,) );
                              }),
                               child: Image.asset("assets/edit.png",height: 60,width: 50,),
                            ),
                           
                          ],
                        ) ,
                        ),
                        Center(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          child: 
                            Text("(ข้อเขียน)",style: TextStyle(fontWeight: FontWeight.bold),)
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
    );
  }
}
