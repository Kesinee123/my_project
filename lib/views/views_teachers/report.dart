import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

String  massege = '';

final textController = new TextEditingController();

  Future problum() async {
    String date = DateFormat.yMMMEd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    DocumentReference problumDocument = await FirebaseFirestore.instance.collection('problum').add({
      "time" : "$date $time",
      "massege" : massege,
      "email" : FirebaseAuth.instance.currentUser!.email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text(
            'แจ้งปัญหาที่เกิดขึ้น',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 120,),
          Opacity(opacity: 0.5,
            child: Image.asset('assets/logo.png', height: 300,),
            ),
          SizedBox(height: 100,),
          // Text(massege),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'ผู้รับ : ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'ADMIN',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                ListTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.purple),
                  borderRadius: BorderRadius.circular(10)),
              title: TextField(
                controller: textController,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    massege = textController.text;
                    textController.clear();
                  });
                  problum();
                  // print("$massege");
                },
                child: Text('ส่ง'),
              ),
            ),
              ],
            ),
          ),
          
        ],
      ),
    )));
  }
}
