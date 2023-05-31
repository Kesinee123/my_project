import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:my_project/views/views_teachers/detail/detail_quizs_homework.dart';

class DetialQuizs_Time extends StatefulWidget {
  const DetialQuizs_Time(
      {super.key,
      required this.quizId,
      required this.questionId,
      required this.path});

  final String quizId;
  final String questionId;
  final String path;

  @override
  State<DetialQuizs_Time> createState() => _DetialQuizs_TimeState();
}

class _DetialQuizs_TimeState extends State<DetialQuizs_Time> {
  // final String _dateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // final String _timeOfDay = DateFormat.Hm().format(DateTime.now());

  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _dateTime = DateTime.now();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime dateTime = DateTime.now();

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('กำหนดส่งงาน'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.white,
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    margin: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'กำหนดส่งการบ้าน',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        GestureDetector(
                          onTap: _showDatePicker,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()} ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        GestureDetector(
                          onTap: _showTimePicker,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.alarm,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  _timeOfDay.format(context).toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple),
                    onPressed: () async {
                      DocumentReference docRef = FirebaseFirestore.instance
                          .collection('quizs')
                          .doc(widget.quizId);

                      await docRef.update({
                        'startMakeQuiz': '${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()} ${timeOfDay.format(context).toString()}',
                        'endMakeQuiz': '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()} ${_timeOfDay.format(context).toString()}',
                      });

                      // print('$hours : $minutes');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetialQuizs_Homework(
                                    quizId: widget.quizId,
                                    questionId: widget.questionId,
                                    // dateTime : '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()} ${_timeOfDay.format(context).toString()}',
                                    // timeOfDay: _timeOfDay.format(context).toString(),
                                    path: widget.path,
                                    startMakeQuiz:
                                        '${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()} ${timeOfDay.format(context).toString()}',
                                    endMakeQuiz:
                                        '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()} ${_timeOfDay.format(context).toString()}',
                                  )));
                    },
                    child: Text(
                      'ต่อไป',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))
              ],
            ),
          ),
        ));
  }

//   Future pickDateTime() async {
//     DateTime? date = await pickDate();
//     if (date == null) return;

//     TimeOfDay? time = await pickTime();
//     if (time == null) return;

//     final dateTime =
//         DateTime(date.year, date.month, date.day, time.hour, time.minute);
//     setState(() => this.dateTime = dateTime);
//   }

//   Future<DateTime?> pickDate() => showDatePicker(
//       context: context,
//       initialDate: dateTime,
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100));

//   Future<TimeOfDay?> pickTime() => showTimePicker(
//       context: context,
//       initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
// }
}
