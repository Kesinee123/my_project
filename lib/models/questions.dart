// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';

// class Questions {
 
//   String questions;
//   String imageUrl;
//   String type_quiz;
//   String correct_answer;
//   Questions({
//     required this.questions,
//     required this.imageUrl,
//     required this.type_quiz,
//     required this.correct_answer,
//   });
  


//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'questions': questions,
//       'imageUrl': imageUrl,
//       'type_quiz': type_quiz,
//       'correct_answer': correct_answer,
//     };
//   }

//   factory Questions.fromMap(Map<String, dynamic> map) {
//     return Questions(
//       questions: map['questions'] as String,
//       imageUrl: map['imageUrl'] as String,
//       type_quiz: map['type_quiz'] as String,
//       correct_answer: map['correct_answer'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Questions.fromJson(String source) => Questions.fromMap(json.decode(source) as Map<String, dynamic>);

//   Questions copyWith({
//     String? questions,
//     String? imageUrl,
//     String? type_quiz,
//     String? correct_answer,
//   }) {
//     return Questions(
//       questions: questions ?? this.questions,
//       imageUrl: imageUrl ?? this.imageUrl,
//       type_quiz: type_quiz ?? this.type_quiz,
//       correct_answer: correct_answer ?? this.correct_answer,
//     );
//   }

//   @override
//   String toString() {
//     return 'Questions(questions: $questions, imageUrl: $imageUrl, type_quiz: $type_quiz, correct_answer: $correct_answer)';
//   }

//   @override
//   bool operator ==(covariant Questions other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.questions == questions &&
//       other.imageUrl == imageUrl &&
//       other.type_quiz == type_quiz &&
//       other.correct_answer == correct_answer;
//   }

//   @override
//   int get hashCode {
//     return questions.hashCode ^
//       imageUrl.hashCode ^
//       type_quiz.hashCode ^
//       correct_answer.hashCode;
//   }
// }
