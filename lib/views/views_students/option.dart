import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/models/option.dart';
import 'package:my_project/models/question.dart';

class optionWidget extends StatefulWidget {
  const optionWidget({key, required this.quizId, required this.questionId});

  final String quizId;
  final String questionId;

  @override
  State<optionWidget> createState() => _optionWidgetState();
}

class _optionWidgetState extends State<optionWidget> {
  @override
  Widget build(BuildContext context) {

      Future<List<Option>> getOptions() async {
    final CollectionReference options =
        FirebaseFirestore.instance.collection('quizs').doc(widget.quizId).collection('questions').doc(widget.questionId).collection('answers');
    QuerySnapshot querySnapshot = await options.get();
    List<Option> optionsList = [];
    querySnapshot.docs.forEach((doc) {
      Option answer = Option(
        id: doc.id,
        answer: doc['answer'],
      );
      optionsList.add(answer);
    });
    return optionsList;
  }

   return Center(
      child: FutureBuilder(
        future: getOptions(), // ดึงข้อมูล Controller
        builder: (context,
            AsyncSnapshot<List<Option>>
                snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount:
                  snapshot.data!.length,
              itemBuilder:
                  (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    title: Text(snapshot
                        .data![index]
                        .answer),
                    // title: Text('คำตอบ'),
                  ),
                );
              },
            );
          } else {
            return Text('No Data');
          }
        },
      ),
    );
  }
}