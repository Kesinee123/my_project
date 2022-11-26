
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_project/views/views_teachers/create_questions.dart';

class DetailsQuizs extends StatefulWidget {
  const DetailsQuizs({super.key, required this.quizId});

  final String quizId;
  

  @override
  State<DetailsQuizs> createState() => _DetailsQuizsState();
}

class _DetailsQuizsState extends State<DetailsQuizs> {
  List<String> popList = ["แก้ไข", "ลบ"];

  // final CollectionReference _quizRef = FirebaseFirestore.instance.collection('quizs');
    DateTime dateTime = DateTime(2022, 12, 24, 5, 30);
    final isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {

    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2,'0');
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async{
        if (isDialOpen.value){
          isDialOpen.value = false;

          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.deepPurple,title: Text(""),),
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
                    onTap: () => 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuestion())),
                    // showToast('...Create Quiz'),
                  )
                ],
              ),
        body: SafeArea(
          child: SingleChildScrollView(
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('quizs').doc(widget.quizId).get(),
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }
              if(snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data!.data();
                return Column(
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          PopupMenuButton(
                                            onSelected: (value) {
                                              if (value == "ลบ") {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return Dialog(
                                                      child: Container(
                                                        height: 50,
                                                        child: Text('ลบ')),
                                                    );
                                                  });
                                              }else{
                                                showDialog(
                                                  context: context, 
                                                  builder: (BuildContext context) {
                                                    return Dialog(
                                                      child: Container(
                                                        height: 50,
                                                        child: Text('แก้ไข')),
                                                    );
                                                  });
                                              }
                                            },
                                            itemBuilder: (context) {
                                              return popList.map((e) => PopupMenuItem(value: e,child: Text(e))).toList();
                                            })
                                        ],
                                      )
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
                                  // Text(
                                  //   "ID : ${widget.quizId}}",
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  Row(
                                    children: [
                                      Text(
                                        "ชื่อแบบทดสอบ :",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        "${documentData['quizTitle']}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ชื่อวิชา : ",
                                        style: TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        "${documentData['quizSubject']}",
                                        style: TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  // Text("${widget.quizId}"),
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
                                                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => detial_Quizs_homepage()));
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
                                                                // Navigator.push(context, MaterialPageRoute(builder: (context) => ShowListName()));
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
              );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          ),
        ),),
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
