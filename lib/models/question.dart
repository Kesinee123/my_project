
  class Quizs {
  late final String id;
  final String quizTitle;
  final String quizSubject;
  final String imageUrl;

  Quizs({
    required this.id,
    required this.quizTitle,
    required this.quizSubject,
    required this.imageUrl,
  });

  factory Quizs.fromMap(Map<String, dynamic> data) {
    return Quizs(
      id: data['quizId'] ?? '',
      quizTitle: data['quizTitle'] ?? '',
      quizSubject: data['quizSubject'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}



class Question {
  late final String id;
  final String question;
  final String typeQuestion;
  final String correct_answer;
  final List<Option> options;

  Question({
    required this.id,
    required this.question,
    required this.correct_answer,
    required this.typeQuestion,
    required this.options,
  });

  factory Question.fromMap(Map<String, dynamic> data) {
    return Question(
      id: data['questionId'] ?? '',
      question: data['question'] ?? '',
      correct_answer: data['correct_answer'] ?? '',
      typeQuestion: data['typeQuestion'] ?? '',
      options: [],
    );
  }
}

class Option {
  final String id;
  final String answer;
  final String identifier;
  final String imageUrl;

  Option({
    required this.id,
    required this.answer,
    required this.identifier,
    required this.imageUrl,
  });

  factory Option.fromMap(Map<String, dynamic> data) {
    return Option(
      id: data['id'] ?? '',
      answer: data['answer'] ?? '',
      identifier: data['identifier'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}

class StudentList {
  final String studentId;
  // final String answer;
  // final String identifier;
  // final String imageUrl;

  StudentList({
    required this.studentId,
  });

  factory StudentList.fromMap(Map<String, dynamic> data) {
    return StudentList(
      studentId: data['studentId'] ?? '',
    );
  }
}

