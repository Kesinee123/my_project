import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/views_students/quizPage.dart';
import 'package:my_project/views/views_teachers/questionQuiz.dart';
import 'package:share_plus/share_plus.dart';

class DetialQuizs_Homework extends StatefulWidget {
  const DetialQuizs_Homework(
      {super.key, required this.quizId, required this.questionId, required this.dateTime, required this.timeOfDay, required this.path});

  final String quizId;
  final String questionId;
  final String dateTime;
  final String timeOfDay;
  final String path;

  @override
  State<DetialQuizs_Homework> createState() => _DetialQuizs_HomeworkState();
}

class _DetialQuizs_HomeworkState extends State<DetialQuizs_Homework> {
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';

  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((c) => openQuiz());
  }

  openQuiz() {
    if (widget.path == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage(quizId: widget.quizId,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('หน้าการบ้าน'),
          centerTitle: true,
        ),
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: size.height,
              child: Stack(children: [
                Center(
                    child: Container(
                  width: 800,
                  margin: EdgeInsets.only(top: 300),
                  height: 700,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: QuestionQuiz(
                    question: question,
                    option1: option1,
                    option2: option2,
                    option3: option3,
                    option4: option4,
                    quizId: widget.quizId,
                    questionId: widget.questionId,
                  ),
                )),
                Container(
                  margin: EdgeInsets.all(20),
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('quizs')
                          .doc(widget.quizId)
                          .get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> documentData =
                              snapshot.data!.data();
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "ชื่อแบบทดสอบ :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${documentData['quizTitle']}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "ชื่อวิชา : ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16 , fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${documentData['quizSubject']}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "เริ่มต้น : ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16 , fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${_dateTime.day.toString()} / ${_dateTime.month.toString()} / ${_dateTime.year.toString()} ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${_timeOfDay.format(context).toString()}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text(
                                    "สิ้นสุด : ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.dateTime,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.timeOfDay,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // แชร์ลิงค์แบบทดสอบให้กับนักเรียน
                              // Row(
                              //   children: [
                              //     Text(
                              //       'แชร์ลิงค์แบบทดสอบให้กับนักเรียน',
                              //       style: TextStyle(color: Colors.white),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       height: 50,
                              //       width: 300,
                              //       decoration: BoxDecoration(
                              //           // borderRadius: BorderRadius.circular(10),
                              //           border: Border.all(
                              //               color: Colors.black, width: 2),
                              //           color: Colors.white),
                              //       child: Container(
                              //         margin: EdgeInsets.all(10),
                              //         child: Row(
                              //           children: [
                              //             Icon(Icons.link),
                              //             SizedBox(
                              //               width: 20,
                              //             ),
                              //             Text('123456789'),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                                  
                              //   ],
                              // ),
                            Row(
                              children: [
                                TextButton(onPressed: () async  {
                                  final dynamicLinkParams = DynamicLinkParameters(
                                    link: Uri.parse('https://google.com'),
                                    uriPrefix: 'https://quizs.page.link',
                                    androidParameters: AndroidParameters(
                                      packageName: 'com.example.my_project' , fallbackUrl: Uri.parse('https://myandroidapp.link') )
                                    );

                                    Uri link = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

                                    print(link);

                                    Share.share(link.toString());
                                  // String url = 'https://quizs.page.link/questionpage';

                                  //  Share.share(url);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.share , color: Colors.white,) , Text('แชร์แบบทดสอบให้นักเรียน' , style: TextStyle(color: Colors.white),)
                                  ],
                                ))
                              ],
                            ),
                            ],
                          );
                        }
                        return CircularProgressIndicator();
                      }),
                )
              ]),
            ),
          ]),
        )));
  }
}
