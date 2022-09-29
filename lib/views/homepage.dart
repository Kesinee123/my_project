import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/AddQuestion.dart';
import 'package:my_project/views/AddQuiz.dart';
import 'package:my_project/views/CreateQuiz.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddQuestion()));
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.purple),
        backgroundColor: Color.fromARGB(255, 252, 220, 254),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Quizs").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    color: Colors.white,
                    height: 120,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.transparent,
                          child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                document["quizImageUrl"],
                              )),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(100, 20, 50, 20),
                          child: Column(
                            children: [
                              Text(
                                document["quizTitle"],
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(document["quizSubject"]),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateQuiz()));
          },
          label: const Text('Create Quiz'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}
