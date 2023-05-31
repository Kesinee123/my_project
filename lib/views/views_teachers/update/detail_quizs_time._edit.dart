import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetialQuizs_Time_Edit extends StatefulWidget {
  const DetialQuizs_Time_Edit({
    Key? key,
    required this.quizId,
    required this.questionId,
    required this.path,
    required this.makeQuizEnd,
  }) : super(key: key);

  final String quizId;
  final String questionId;
  final String path;
  final String makeQuizEnd;

  @override
  State<DetialQuizs_Time_Edit> createState() => _DetialQuizs_Time_EditState();
}

class _DetialQuizs_Time_EditState extends State<DetialQuizs_Time_Edit> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _dateTime = DateTime.now();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime dateTime = DateTime.now();

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _timeOfDay = value;
        });
      }
    });
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('แก้ไขกำหนดส่งงาน'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'แก้กำหนดส่งการบ้าน',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _showDatePicker,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.white),
                            SizedBox(width: 20),
                            Text(
                              '${DateFormat('dd/MM/yyyy').format(_dateTime)}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _showTimePicker,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.alarm, color: Colors.white),
                            SizedBox(width: 20),
                            Text(
                              _timeOfDay.format(context).toString(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'ค่าเวลาเดิม: ${widget.makeQuizEnd}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                ),
                onPressed: () async {
                  // DateTime updatedDateTime = DateTime(
                  //   _dateTime.year,
                  //   _dateTime.month,
                  //   _dateTime.day,
                  //   _timeOfDay.hour,
                  //   _timeOfDay.minute,
                  // );

                  DocumentReference docRef = FirebaseFirestore.instance
                      .collection('quizs')
                      .doc(widget.quizId);

                  await docRef.update({
                    'startMakeQuiz':
                        '${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()} ${timeOfDay.format(context).toString()}',
                    'endMakeQuiz':
                        '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()} ${_timeOfDay.format(context).toString()}',
                  });

                  print(widget.quizId);

                  Navigator.pop(context); // ปิด dialog
                },
                child: Text(
                  'แก้ไข',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
