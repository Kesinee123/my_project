import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/views_teachers/detail_quizs_homework.dart';
import 'package:my_project/views/views_teachers/showListname.dart';

class detail_Quizs extends StatefulWidget {
  const detail_Quizs({super.key});

  @override
  State<detail_Quizs> createState() => _detail_QuizsState();
}

class _detail_QuizsState extends State<detail_Quizs> {
  DateTime dateTime = DateTime(2022, 12, 24, 5, 30);
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2,'0');
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(children: [
                Center(
                  child: Container(
                    width: 800,
                      margin: EdgeInsets.only(top: size.height * 0.2),
                      height: 600,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: Container(
                        margin: EdgeInsets.all(24),
                        child: Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Container(
                            margin: EdgeInsets.all(30),
                            height: 320,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text(
                                  "โจทย์ข้อที่ 1",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                      "โจทย์ : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("โจทย์คำถาม"),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "คำตอบ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Icon(Icons.circle,
                                                  size: 20, color: Colors.green),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("คำตอบที่ 1"),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Icon(Icons.circle,
                                                  size: 20, color: Colors.red),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("คำตอบที่ 2"),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Icon(Icons.circle,
                                                  size: 20, color: Colors.red),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("คำตอบที่ 3"),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Icon(Icons.circle,
                                                  size: 20, color: Colors.red),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("คำตอบที่ 4"),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Text(
                                      //         "${snapshot.data!.docs[index].id}"
                                      //       ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
                Center(
                  child: Container(
                    width: 800,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ชื่อของแบบทดสอบ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "ชื่อวิชาของแบบทดสอบ",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.purpleAccent),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Column(
                                                      children: [
                                                        Text('กำหนดวันที่ส่งงาน'),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text('วันที่กำหนดส่ง',style: TextStyle(fontSize: 16),),
                                                            SizedBox(width: 10,),
                                                            ElevatedButton(
                                                                onPressed: () async {
                                                                  final date = await pickDate();
                                                                  if (date == null) return;
                      
                                                                  final newDateTime = DateTime(
                                                                      dateTime.year,
                                                                      dateTime.month,
                                                                      dateTime.day,
                                                                      dateTime.hour,
                                                                      dateTime.minute
                                                                      
                                                                  );
                      
                                                                  setState(() => dateTime = date );
                                                                 
                                                                },
                                                                child: Text(
                                                                    '${dateTime.year}/${dateTime.month}/${dateTime.day}')),
                                                          ],
                                                        ),
                                                        SizedBox(height: 20,),
                                                        Row(
                                                          children: [
                                                            Text('เวลากำหนดส่ง',style: TextStyle(fontSize: 16),),
                                                            SizedBox(width: 10,),
                                                            ElevatedButton(
                                                                onPressed: () async {
                                                                 final time = await pickTime();
                                                                 if (time == null) return;
                      
                                                                 final newDateTime = DateTime(
                                                                      dateTime.year,
                                                                      dateTime.month,
                                                                      dateTime.day,
                                                                      time.hour,
                                                                      time.minute
                                                                  );
                                                                  setState(() => dateTime = newDateTime);
                                                                },
                                                                child: Text(
                                                                    '$hours:$minutes')),
                                                          ],
                                                        ),
                                                        SizedBox(height: 20,),
                                                          Container(
                                                            alignment: Alignment.centerRight,
                                                            child: TextButton(
                                                              onPressed: (){
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => detial_Quizs_homepage()));
                                                              },
                                                              child: Text('Next',style: TextStyle(color: Colors.black,fontSize: 20),)),
                                                          )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Text('HomeWork'))),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.purpleAccent),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Column(
                                                      children: [
                                                        Text('Code ClassRoom'),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          alignment: Alignment.center,
                                                          height: 50,
                                                          width: 100,
                                                          color: Colors.purple,
                                                          child: Text(
                                                            "123456",
                                                            style: TextStyle(
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                        SizedBox(height: 20,),
                                                        ElevatedButton.icon(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.orange
                                                          ),
                                                          onPressed: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowListName()));
                                                        },
                                                        icon: Icon(Icons.arrow_circle_right_outlined,size: 30,), label: Text('START'))
                                                        
                                                      ],
                                                    ),
                                                  );
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
                                            "https://png.pngtree.com/png-clipart/20190117/ourlarge/pngtree-cartoon-book-notes-stationery-png-image_424364.jpg")),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
       date.day,
      time.hour,
      time.minute
    );
    setState(() => this.dateTime= dateTime);
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
