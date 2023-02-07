import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_project/views/views_teachers/add_quizs.dart';
import 'package:my_project/views/views_teachers/create_questions.dart';
import 'package:my_project/views/views_teachers/detail_quizs_time.dart';
import 'package:my_project/views/views_teachers/detail_quizs_homework.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/listName_Student.dart';
import 'package:my_project/views/views_teachers/questionQuiz.dart';

class DetailsQuizs extends StatefulWidget {
  const DetailsQuizs(
      {super.key, required this.quizId, required this.questionId});

  final String quizId;
  final String questionId;

  @override
  State<DetailsQuizs> createState() => _DetailsQuizsState();
}

class _DetailsQuizsState extends State<DetailsQuizs> {
  final isDialOpen = ValueNotifier(false);
  DateTime dateTime = DateTime(2022, 12, 24, 5, 30);

  // final controller = TextEditingController();
  late TextEditingController controller;
  bool isButtonActive = true;
  bool isButtonActive1 = true;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive1 = controller.text.isNotEmpty;

      setState(() => this.isButtonActive1 = isButtonActive1);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

    randomString() {
    if ( controller.text == null) {
      return '';
    } else {
      return '....';
    }
  }

  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;

          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // leading: BackButton(onPressed: () => HomePage()),
            backgroundColor: Colors.deepPurple,
            // automaticallyImplyLeading: false,
          ),
          backgroundColor: Colors.deepPurple,
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.purple,
            overlayColor: Colors.white,
            overlayOpacity: 0.4,
            spacing: 12,
            // closeManually: true,
            openCloseDial: isDialOpen,
            children: [
              SpeedDialChild(
                backgroundColor: Colors.white,
                child: Icon(Icons.edit),
                label: 'สร้างโจทย์คำถาม',
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddQuiz(
                              quizId: widget.quizId,
                              questionId: widget.questionId,
                            ))),
                // showToast('...Create Quiz'),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('quizs')
                    .doc(widget.quizId)
                    .get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> documentData = snapshot.data!.data();
                    return Column(
                      children: [
                        SizedBox(
                          height: size.height,
                          child: Stack(children: [
                            QuestionQuiz(
                              question: question,
                              option1: option1,
                              option2: option2,
                              option3: option3,
                              option4: option4,
                              quizId: widget.quizId,
                              questionId: widget.questionId,
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text(
                                          "${documentData['quizTitle']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "ชื่อวิชา : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${documentData['quizSubject']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    // Text(
                                    //   "ID : ${widget.quizId}",
                                    //   style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 16,
                                    //       ),
                                    // ),

                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              height: 40,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors
                                                              .purpleAccent),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetialQuizs_Time()));
                                                    // showDialog(
                                                    //     context: context,
                                                    //     builder: (BuildContext
                                                    //         context) {
                                                    //       return AlertDialog(
                                                    //         title: Column(
                                                    //           children: [
                                                    //             Text(
                                                    //                 'กำหนดวันที่ส่งงาน'),
                                                    //             SizedBox(
                                                    //               height: 20,
                                                    //             ),
                                                    //             Row(
                                                    //               children: [
                                                    //                 Text(
                                                    //                   'วันที่กำหนดส่ง',
                                                    //                   style: TextStyle(
                                                    //                       fontSize:
                                                    //                           16),
                                                    //                 ),
                                                    //                 SizedBox(
                                                    //                   width: 10,
                                                    //                 ),
                                                    //                 ElevatedButton(
                                                    //                     onPressed:
                                                    //                         () async {
                                                    //                       final date =
                                                    //                           await pickDate();
                                                    //                       if (date ==
                                                    //                           null)
                                                    //                         return;

                                                    //                       final newDateTime = DateTime(
                                                    //                           dateTime.year,
                                                    //                           dateTime.month,
                                                    //                           dateTime.day,
                                                    //                           dateTime.hour,
                                                    //                           dateTime.minute);

                                                    //                       setState(() =>
                                                    //                           dateTime = date);
                                                    //                     },
                                                    //                     child: Text(
                                                    //                         '${dateTime.year}/${dateTime.month}/${dateTime.day}')),
                                                    //               ],
                                                    //             ),
                                                    //             SizedBox(
                                                    //               height: 20,
                                                    //             ),
                                                    //             Row(
                                                    //               children: [
                                                    //                 Text(
                                                    //                   'เวลากำหนดส่ง',
                                                    //                   style: TextStyle(
                                                    //                       fontSize:
                                                    //                           16),
                                                    //                 ),
                                                    //                 SizedBox(
                                                    //                   width: 10,
                                                    //                 ),
                                                    //                 ElevatedButton(
                                                    //                     onPressed:
                                                    //                         () async {
                                                    //                       final time =
                                                    //                           await pickTime();
                                                    //                       if (time ==
                                                    //                           null)
                                                    //                         return;

                                                    //                       final newDateTime = DateTime(
                                                    //                           dateTime.year,
                                                    //                           dateTime.month,
                                                    //                           dateTime.day,
                                                    //                           time.hour,
                                                    //                           time.minute);
                                                    //                       setState(() =>
                                                    //                           dateTime = newDateTime);
                                                    //                     },
                                                    //                     child: Text(
                                                    //                         '$hours:$minutes')),
                                                    //               ],
                                                    //             ),
                                                    //             SizedBox(
                                                    //               height: 20,
                                                    //             ),
                                                    //             Container(
                                                    //               alignment:
                                                    //                   Alignment
                                                    //                       .centerRight,
                                                    //               child:
                                                    //                   TextButton(
                                                    //                       onPressed:
                                                    //                           () {
                                                    //                         Navigator.push(context,
                                                    //                             MaterialPageRoute(builder: (context) => DetialQuizs_Homework()));
                                                    //                       },
                                                    //                       child:
                                                    //                           Text(
                                                    //                         'Next',
                                                    //                         style:
                                                    //                             TextStyle(color: Colors.black, fontSize: 20),
                                                    //                       )),
                                                    //             )
                                                    //           ],
                                                    //         ),
                                                    //       );
                                                    //     });
                                                  },
                                                  child: Text('HomeWork'))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              height: 40,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors
                                                              .purpleAccent),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          // return DetialQuizs_Classroom();
                                                          return AlertDialog(
                                                              title: Container(
                                                            // padding: EdgeInsets.all(20),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Random Code',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 12,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      controller,
                                                                  readOnly:
                                                                      true,
                                                                  enableInteractiveSelection:
                                                                      false,
                                                                  decoration: InputDecoration(
                                                                      border: OutlineInputBorder(),
                                                                      suffixIcon: IconButton(
                                                                          onPressed: () {
                                                                            final data =
                                                                                ClipboardData(text: controller.text);
                                                                            Clipboard.setData(data);
                                                                            showSnackbar(
                                                                                context,
                                                                                Colors.green,
                                                                                'Code Copied');
                                                                            // final snackBar = SnackBar(content: Text('Code Copied' , style: TextStyle(
                                                                            //   fontWeight: FontWeight.bold
                                                                            // ),),
                                                                            // backgroundColor: Colors.deepPurple,
                                                                            // );
                                                                          },
                                                                          icon: Icon(Icons.copy))),
                                                                ),
                                                                SizedBox(
                                                                  height: 12,
                                                                ),
                                                                buildButton(),
                                                              ],
                                                            ),
                                                          ));
                                                        });
                                                  },
                                                  child: Text('ClassRoom'))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: CircleAvatar(
                                                radius: 60,
                                                backgroundImage: NetworkImage(
                                                  "${documentData['imageUrl']}",
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ]),
                        )
                      ],
                    );
                  }
                  // return Scaffold(
                  //   body: Center(
                  //     child: CircularProgressIndicator(),
                  //   ),
                  // );
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ),
    );
  }

  // Classroom
  Widget buildButton() {
    final backgroundColor = MaterialStateColor.resolveWith(
      (states) => states.contains(MaterialState.pressed)
          ? Colors.deepPurple
          : Colors.black,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            style: ButtonStyle(backgroundColor: backgroundColor),
            onPressed: isButtonActive
                ? () {
                    final password = generatePassword();

                    controller.text = password;
                    setState(
                      () => isButtonActive = false,
                    );
                  }
                : null,
            child: Text('Random')),
        controller.text != '' ? ElevatedButton(
            onPressed: () {
              // if (controller.text != '') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListName_Student()));
              // } else {
              //   showSnackbar(context, Colors.red, 'กรุณากดปุ่ม Random');
              // }
            },
            child: Text(
              'Start',
              style: TextStyle(fontWeight: FontWeight.bold),
            )) : Text('')
      ]
    );
  }

  // Widget buildButton2() {
  //   return ElevatedButton(onPressed: (){},
  //   child: Text('Start', style: TextStyle(fontWeight: FontWeight.bold),));
  // }

  String generatePassword({
    bool hasLetters = true,
    bool hasNumber = true,
  }) {
    final length = 8;
    final lettersLowercase = 'abcdefghijklmnopqrstuvwxyz';
    final lettersUpercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final number = '0123456789';

    String chars = '';
    if (hasLetters) chars += '$lettersUpercase$lettersLowercase';
    if (hasNumber) chars += '$number';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);

      return chars[indexRandom];
    }).join('');
  }

  // Homework
  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() => this.dateTime = dateTime);
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: Duration(seconds: 5),
  ));
}
