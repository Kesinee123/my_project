import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/views/views_students/questionWidget.dart';

class LetPage extends StatefulWidget {
  const LetPage({Key? key}) : super(key: key);
  @override
  State<LetPage> createState() => _LetPageState();
}

class _LetPageState extends State<LetPage> {
  final TextEditingController _numberController = TextEditingController();
  bool _isValid = false;

  void _checkNumberValidity() async {
  String inputNumber = _numberController.text.trim();
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('quizs')
      .where('code', isEqualTo: inputNumber)
      .get();
  if (querySnapshot.docs.length > 0) {
    setState(() {
      _isValid = true;
    });
  }
  if (_isValid) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionWidget(
          // quizCode: inputNumber,
          quizId: querySnapshot.docs[0].id, // ส่งข้อมูลไปด้วย
        ),
      ),
    );
  } else {
     showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("แจ้งเตือน", style: TextStyle(fontWeight: FontWeight.bold),),
          content: Text("code แบบทดสอบที่คุณป้อนไม่ถูกต้อง กรุณาลองอีกครั้ง."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('ตกลง'),
            )
          ]));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 151, 114, 253),
        body: SafeArea(
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/logo.png", height: 150)
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 176, 97, 255),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextField(
                                    controller: _numberController,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.code_sharp,
                                        ),
                                        hintText: "กรุณากรอก code",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow),
                            onPressed: _checkNumberValidity,
                            child: Text('เข้าร่วมแบบทดสอบ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          )),
                          
        
                          // Container(
                          //   child: Text('ผ่านนนนน'),
                          // )
                        ])))
              ])),
        ));
  }
}
// RawMaterialButton(
// onPressed: _checkNumberValidity,
// // Navigator.push(context, MaterialPageRoute(builder: (context){return QuestionWidget();},));