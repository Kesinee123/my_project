import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/models/menu_item.dart';
import 'package:my_project/views/views_teachers/detail/details.dart';

class QuizDetailList extends StatefulWidget {
  QuizDetailList({super.key, required this.path});

  final String path;

  // final String quizId;

  @override
  State<QuizDetailList> createState() => _QuizDetailListState();
}

class _QuizDetailListState extends State<QuizDetailList> {
  List<String> popList = ["แก้ไข", "ลบ"];

  final TextEditingController quizTitleEdit = TextEditingController();
  final TextEditingController quizSubjectEdit = TextEditingController();

  Future<void> _deleteQuiz(id) async {
    await FirebaseFirestore.instance.collection("quizs").doc(id).delete();
  }

  File? _image;
  String? _imageUrl;
  final picker = ImagePicker();
  //String? downloadURL;

  Future imagePicker() async {
    try {
      final pick = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (picker != null) {
          _image = File(pick!.path);
        } else {
          showSnackbar(context, Colors.red, "ไม่มีรูปภาพ");
        }
      });
    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
    }
  }

  Future uploadImage(File _image) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('images').child('quiz$imgId');
    await reference.putFile(_image);
    url = await reference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("quizs")
            // .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length != 0) {
            } else {
              return noQuiz();
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.deepPurple),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsQuizs(
                                          quizId: documentSnapshot.id,
                                          questionId: documentSnapshot.id,
                                          path: widget.path,
                                        )));
                          },
                          child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              leading: CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      documentSnapshot['imageUrl'])),
                              title: Text(
                                documentSnapshot['quizTitle'],
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    documentSnapshot['quizSubject'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton(onSelected: (value) {
                                if (value == "ลบ") {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                              title: Text(
                                                "แจ้งเตือน",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: Text(
                                                  "ต้องการลบแบบทดสอบหรือไม่ ??"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('ยกเลิก'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    _deleteQuiz(
                                                        documentSnapshot.id);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('ลบ'),
                                                )
                                              ]));
                                } else {
                                  quizTitleEdit.text =
                                      documentSnapshot['quizTitle'];
                                  quizSubjectEdit.text =
                                      documentSnapshot['quizSubject'];
                                  _imageUrl = documentSnapshot['imageUrl'];

                                  showDialog(
  context: context,
  builder: (BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'แก้ไขแบบทดสอบ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.deepPurple),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _image == null
                        ? Center(child: Image.network(documentSnapshot['imageUrl']))
                        : Image.file(_image!),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.yellow),
                  onPressed: () {
                    imagePicker();
                  },
                  child: Text(
                    'เพิ่มรูปภาพ',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: quizTitleEdit,
                  decoration: InputDecoration(
                    labelText: "ชื่อแบบทดสอบ",
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: quizSubjectEdit,
                  decoration: InputDecoration(
                    labelText: "ชื่อวิชาของแบบทดสอบ",
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('ยกเลิก'),
                    ),
                    SizedBox(width: 100),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                      onPressed: () async {
                        if (_image != null) {
                          _imageUrl = await uploadImage(_image!);
                        } else {
                          _imageUrl = 'https://img.icons8.com/sf-regular-filled/256/question-mark.png';
                        }
                        snapshot.data!.docs[index].reference.update({
                          "quizTitle": quizTitleEdit.text,
                          "quizSubject": quizSubjectEdit.text,
                          "imageUrl": _imageUrl,
                        });
                        Navigator.pop(context);
                      },
                      child: Text('ตกลง'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
);

                                }
                              }, itemBuilder: (context) {
                                return popList
                                    .map((e) =>
                                        PopupMenuItem(value: e, child: Text(e)))
                                    .toList();
                              })),
                        ),
                      ),
                    ],
                  );
                });
          } else {
            // return Scaffold(body: Center(child: CircularProgressIndicator()));
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  noQuiz() {
    return Container(
      margin: EdgeInsets.all(50),
      child: Center(
          child: Column(
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/512/29/29302.png',
            height: 150,
          ),
          Text(
            'ไม่มีแบบทดสอบที่สร้าง',
            style: TextStyle(fontSize: 20),
          ),
        ],
      )),
    );
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
