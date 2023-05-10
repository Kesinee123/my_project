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
  String massege = '';

  final textController = new TextEditingController();

  Future problum() async {
    String date = DateFormat.yMMMEd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    DocumentReference problumDocument =
        await FirebaseFirestore.instance.collection('problum').add({
      "time": "$date $time",
      "massege": massege,
      "email": FirebaseAuth.instance.currentUser!.email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'แจ้งปัญหาที่เกิดขึ้น',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
          Stack(children: [
            Center(
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/logo.png',
                  height: 300,
                ),
              ),
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('problum')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return Dismissible(
                        key: Key(documentSnapshot.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          // กำหนดการลบของข้อมูลที่ถูกสไลด์
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 100,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                'ปัญหาที่แจ้ง',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Flexible(
                                child: Text(
                                  documentSnapshot['massege'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              trailing: Text(
                                'กำลังดำเนินการ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ]),
          SizedBox(
            height: 160,
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'ผู้รับ : ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                SizedBox(
                  height: 20,
                ),
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
