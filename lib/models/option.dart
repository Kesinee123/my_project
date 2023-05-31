// import 'package:cloud_firestore/cloud_firestore.dart';

// class Option {
//   final String id;
//   final String answer;
//   final String identifier;
//   final String imageUrl;

//   Option({
//     required this.id,
//     required this.answer,
//     required this.identifier,
//      required this.imageUrl,
//   });
  
// }

// // class OptionData {
// //   static Future<List<Option>> getOptions() async {
// //     final CollectionReference options =
// //         FirebaseFirestore.instance.collection('quizs')
// //         .doc('bCoH94IdwMPRkf1wyWE4')
// //         .collection('questions')
// //         .doc('6M4MhgSrPrcw9rMDGUm6')
// //         .collection('answers');
// //   QuerySnapshot querySnapshot = await options.get();
// //     List<Option> optionList = [];
// //     querySnapshot.docs.forEach((doc) {
// //       Option option = Option(
// //         id: doc.id,
// //         answer: doc['answer'],
// //       );
// //       optionList.add(option);
// //     });
// //     return optionList;
// //   }
// // }