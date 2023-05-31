import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_project/views/views_students/codePage.dart';
import 'package:my_project/views/views_teachers/add_quizs.dart';
import 'package:my_project/views/views_teachers/create/create_questions.dart';
import 'package:my_project/views/views_teachers/detail/detail_quiz_code.dart';
import 'package:my_project/views/views_teachers/detail/detail_quizs_time.dart';
import 'package:my_project/views/views_teachers/detail/detail_quizs_homework.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/listName_Student.dart';
import 'package:my_project/views/views_teachers/path_constant.dart';
import 'package:my_project/views/views_teachers/questionQuiz.dart';

import '../../../config/responsive.dart';

class DetailsQuizs extends StatefulWidget {
  const DetailsQuizs(
      {super.key,
      required this.quizId,
      required this.questionId,
      required this.path});

  final String quizId;
  final String questionId;
  final String path;

  @override
  State<DetailsQuizs> createState() => _DetailsQuizsState();
}

class _DetailsQuizsState extends State<DetailsQuizs> {
  final isDialOpen = ValueNotifier(false);
  // DateTime dateTime = DateTime(2022, 12, 24, 5, 30);

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
    if (controller.text == null) {
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
    // final hours = dateTime.hour.toString().padLeft(2, '0');
    // final minutes = dateTime.minute.toString().padLeft(2, '0');

//     String? _linkMessage;
//     bool _isCreatingLink = false;

//     FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

//     Future<void> initDynamicLinks(BuildContext context) async {
//   dynamicLinks.onLink.listen((dynamicLinkData) {
//     final Uri uri = dynamicLinkData.link;
//     final queryParams = uri.queryParameters;
//     // เปิดหน้าใหม่ภายในแอปพลิเคชัน
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => LetPage()),
//     );
//   }).onError((error) {
//     print('onLink error');
//     print(error.message);
//   });
// }

//     @override
//     void initState() {
//       super.initState();
//       initDynamicLinks(context);
//     }

//     Future<void> _createDynamicLink(bool short, String link) async {
//       setState(() {
//         _isCreatingLink = true;
//       });
//       final DynamicLinkParameters parameters = DynamicLinkParameters(
//         link: Uri.parse(kUiPrefix + link),
//         uriPrefix: kUiPrefix,
//         androidParameters: AndroidParameters(
//             packageName: 'com.example.my_project', minimumVersion: 125),
//       );

//       Uri url;
//       if (short) {
//         final ShortDynamicLink shortlink =
//             await dynamicLinks.buildShortLink(parameters);
//         url = shortlink.shortUrl;
//       } else {
//         url = await dynamicLinks.buildLink(parameters);
//       }

//       setState(() {
//         _isCreatingLink = false;
//         _linkMessage = url.toString();
//       });
//     }

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
                child: const Icon(Icons.edit),
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
              child: SafeArea(
                  child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: size.height,
                child: Stack(children: [
                  Center(
                      child: Container(
                    width: 800,
                    margin: const EdgeInsets.only(top: 200),
                    height: 600,
                    decoration: const BoxDecoration(
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
                    margin: const EdgeInsets.all(20),
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('quizs')
                            .doc(widget.quizId)
                            .get(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> documentData =
                                snapshot.data!.data();
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "ชื่อแบบทดสอบ :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${documentData['quizTitle']}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "ชื่อวิชา : ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${documentData['quizSubject']}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 50,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.purpleAccent),
                                        onPressed: () {
                                          if (documentData['startMakeQuiz'] == null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetialQuizs_Time(
                                                  quizId: widget.quizId,
                                                  questionId: widget.questionId,
                                                  path: widget.path,
                                                ),
                                              ),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetialQuizs_Homework(
                                                  quizId: widget.quizId,
                                                  path: widget.path,
                                                  questionId: widget.questionId,
                                                  startMakeQuiz: documentData[
                                                          'startMakeQuiz'],
                                                  endMakeQuiz: documentData[
                                                          'endMakeQuiz'],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text('การบ้าน')),
                                    // SizedBox(
                                    //   width: 30,
                                    // ),

                                    // ElevatedButton(
                                    //   style: ElevatedButton.styleFrom(
                                    //       primary: Colors.purpleAccent),
                                    //   onPressed:
                                    //   !_isCreatingLink
                                    //       ? () async {
                                    //           await _createDynamicLink(
                                    //               true, kCodeLink);
                                    //           String link = _linkMessage ??
                                    //               ''; // Ensure link is not null
                                    //           // await FirebaseFirestore.instance
                                    //           //     .collection('link')
                                    //           //     .add({
                                    //           //   "Link": link,
                                    //           // });
                                    //           Navigator.push(context, MaterialPageRoute(builder: (context) => DetialQuizs_Code(
                                    //             quizId: widget.quizId, link: link.toString(),)));
                                    //         }
                                    //       : null,
                                    //   child: Text('ห้องเรียน'),
                                    // ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.purpleAccent),
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetialQuizs_Code(
                                                      quizId: widget.quizId,
                                                    )));
                                      },
                                      child: const Text('ห้องเรียน'),
                                    ),

                                    CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          "${documentData['imageUrl']}",
                                        ))
                                  ],
                                ),
                              ],
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                  )
                ]),
              ),
            ]),
          ))),
        ),
      ),
    );
  }

  void showSnackbar(context, color, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 5),
    ));
  }
}
