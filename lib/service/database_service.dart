// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_project/models/question.dart';

// class DatabaseService {
//   final String? uid;
//   DatabaseService({this.uid});


//   final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
//   final CollectionReference quizCollection = FirebaseFirestore.instance.collection("quizs");
//   final CollectionReference questionCollection = FirebaseFirestore.instance.collection("questions");


//   Future updateUserData(String email, String type, String firstName, String lastName ) async {
//     return await userCollection.doc(uid).set({
//       'email':email,
//       'firstName': firstName,
//       'lastName': lastName,
//       'type': type,
//       // 'quizs' : [],
//       'uid' : uid
//     }); 
//   }

//   Future gettingUserData(String email) async {
//     QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
//   }

//   getUserQuiz() async {
//     return userCollection.doc(uid).snapshots();
//   }

//   // creating a quizs
//   Future createQuiz(String userName, String id, String quizTitle, String quizSubject) async {
//     DocumentReference quizDocumentReference = await quizCollection.add({
//       "quizTitle" : quizTitle,
//       "quizSubject" : quizSubject,
//       "imageURL" : "",
//       "questions" : [],
//       "quizId" : "",
//     });
//     // update the quiz
//     await quizDocumentReference.update({
//       // "questions" : FieldValue.arrayUnion(["${uid}_$userName"]),
//       "quizId" : quizDocumentReference.id
//     });

//     DocumentReference userDocumentReference = userCollection.doc(uid);
//     return await userDocumentReference.update({
//       "quizs" : FieldValue.arrayUnion(["${quizDocumentReference.id}_$quizTitle"])
//     });
//   }

//   // create a question
//   Future createQuestion(String userName, String id, String question) async {
//     DocumentReference questionDocumentReference = await questionCollection.add({
//       "questionName" : question,
//       "questionId" : "",
//       'quizs' : [],
//     });
//      // update the question
//     await questionDocumentReference.update({
//       "questionId" : questionDocumentReference.id
//     });

//    DocumentReference userDocumentReference = userCollection.doc(uid);
//     return await userDocumentReference.update({
//       "questions" : FieldValue.arrayUnion(["${questionDocumentReference.id}"])
//     });
//   }
// }

