import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/views_teachers/detail_quizs_homework.dart';

class DetialQuizs_Time extends StatefulWidget {
  const DetialQuizs_Time({super.key, required this.quizId, required this.questionId});

  final String quizId;
  final String questionId;

  @override
  State<DetialQuizs_Time> createState() => _DetialQuizs_TimeState();
}

class _DetialQuizs_TimeState extends State<DetialQuizs_Time> {
  DateTime? _dateTime;
  DateTime dateTime = DateTime(2022, 12, 24, 5, 30);

  _dateString() {
    if (_dateTime == null) {
      return 'เลือกวันที่ต้องการ';
    } else {
      return '${_dateTime?.day} - ${_dateTime?.month} - ${_dateTime?.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.white,
                  width: 300,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Container(
                    margin: EdgeInsets.all(30),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'กำหนดส่งการบ้าน',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple),
                            onPressed: () async {
                              final result = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2050));
                              if (result != null) {
                                setState(() {
                                  _dateTime = result;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  _dateString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple
                          ),
                            onPressed: () async {
                              final time = await pickTime();
                              if (time == null) return;
                              

                              final newDateTime = DateTime(
                                  dateTime.year,
                                  dateTime.month,
                                  dateTime.day,
                                  time.hour,
                                  time.minute);
                              setState(() => dateTime = newDateTime);
                            },
                            child: Row(
                              children: [Icon(Icons.alarm),
                              SizedBox(width: 20,),
                                Text('$hours : $minutes' , style: TextStyle(fontSize: 18),),
                              ],
                            )),
                            SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple
                  ),
                  onPressed: (){
                    // print('$hours : $minutes');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetialQuizs_Homework(quizId: widget.quizId , questionId: widget.questionId,)));
                  }, 
                child: Text('ต่อไป', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),))
              ],
            ),
          ),
        ));
  }

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
