import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/views_students/codePage.dart';
import 'package:my_project/views/views_students/profileStudent.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);
  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String date = DateFormat.yMMMMd().format(DateTime.now());
  String time = DateFormat.Hm().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 151, 114, 253),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // greetings row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Hi Jatuporn!
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Text('Hi Welcome!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        date + " " + time,
                        style: TextStyle(color: Colors.black38),
                      ),
                   ],
                 ),
                  //Notification
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 202, 175, 249),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: IconButton(
                      icon: Icon(Icons.supervised_user_circle_sharp),
                      color: Colors.black, onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProfileSPage();
                      })); },
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 25,
              ),
              
              // search bar
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 202, 175, 249),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LetPage()));
                  },
                  child: Container(
                    height: 30,
                    child: Row(
                      children: [
                        Icon(Icons.work_history),
                        SizedBox(
                          width: 5,
                        ),
                        Text('QuizzzTest',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
        ),
      ),
    );
  }
 
}