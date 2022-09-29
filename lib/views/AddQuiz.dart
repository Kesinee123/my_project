import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/AddQuestion.dart';
import 'package:my_project/views/CreateQuestion.dart';
import 'package:my_project/views/CreateQuiz.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purpleAccent),
      backgroundColor: Color.fromARGB(255, 252, 220, 254),
      body: Column(
        
        children: [
          Text("Add Question",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
           height: MediaQuery.of(context).size.height * 0.35,
           child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12 ),
           ),
           elevation: 8,
           child: Row(
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
                            onPressed: (() {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuestion() ,) );
                            }),
                             child: Image.network("https://www.shareicon.net/data/64x64/2016/11/14/852020_circle-dot-o_512x512.png",height: 60,width: 50,),
                             
                          ),

                        ],
                      ) ,
                      ),
                   ],
                 ),
               ),
               Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: (() {
                              
                            }),
                             child: Image.network("https://www.shareicon.net/data/64x64/2016/11/14/852157_check_512x512.png",height: 60,width: 50,),
                          ),
                        ],
                      ) ,
                      ),
                   ],
                 ),
               ),
               Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: (() {
                              
                            }),
                             child: Image.network("https://www.shareicon.net/data/64x64/2017/05/09/885767_edit_512x512.png",height: 60,width: 50,),
                          ),
                        ],
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
    );
  }
}
