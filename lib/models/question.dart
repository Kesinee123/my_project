// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuestionModel {
  String id;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;

  QuestionModel({required this.id,required this.question,required this.option1,required this.option2,required this.option3,required this.option4});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id' : id,
      'question': question,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
       id: map['id'] as String,
      question: map['question'] as String,
      option1: map['option1'] as String,
      option2: map['option2'] as String,
      option3: map['option3'] as String,
      option4: map['option4'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
