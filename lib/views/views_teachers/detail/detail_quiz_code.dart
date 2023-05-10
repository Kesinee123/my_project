import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/views_students/codePage.dart';
import 'package:my_project/views/views_teachers/listName_Student.dart';
import 'package:my_project/views/views_teachers/path_constant.dart';
import 'package:random_string/random_string.dart';
import 'package:url_launcher/url_launcher.dart';

class DetialQuizs_Code extends StatefulWidget {
  const DetialQuizs_Code({super.key, required this.quizId});

  final String quizId;
  // final String link;

  @override
  State<DetialQuizs_Code> createState() => _DetialQuizs_CodeState();
}

class _DetialQuizs_CodeState extends State<DetialQuizs_Code> {
  String code = randomAlphaNumeric(8);

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> documentSnapshot =
        FirebaseFirestore.instance
            .collection('quizs')
            .doc(widget.quizId)
            .snapshots();

    documentSnapshot.listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      Map<String, dynamic>? data = snapshot.data();

      FirebaseFirestore.instance
          .collection('quizs')
          .doc(widget.quizId)
          .update({'code': code});
    });

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
          height: 1000,
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.deepPurple, Colors.purple])),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // color: Colors.white,
                    width: 350,
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      margin: EdgeInsets.all(30),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'เข้าทำแบบทดสอบ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  code,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                                IconButton(
                                    onPressed: () {
                                      final codes = ClipboardData(text: code);
                                      Clipboard.setData(codes);
                                      showSnackbar(context, Colors.green,
                                          'คัดลอกรหัสแล้ว');
                                    },
                                    icon: Icon(Icons.copy))
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          backgroundColor: Colors.deepPurpleAccent),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListName_Student(
                                  quizId: widget.quizId,)));
                      },
                      child: Text(
                        'เริ่มต้น',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ))
                ],
              ),
            ),
          ),
        ));
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
}
