class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });
}

final questions = [
  Question(text: 'ถ้า 3x + 1 = 13 และ 3(y - 2) = 9', options: [
    const Option(text: '7', isCorrect: false),
    const Option(text: '8', isCorrect: false),
    const Option(text: '9', isCorrect: true),
    const Option(text: '15', isCorrect: false),
  ]),
  Question(text: 'สามในสี่เท่าของผลบวกของเลขจำนวนหนึ่ง กับ 3 มีค่าเท่ากับ 45 เลขจำนวนนั้นมีค่าเท่าใด', options: [
    const Option(text: '67', isCorrect: false),
    const Option(text: '87', isCorrect: false),
    const Option(text: '57', isCorrect: true),
    const Option(text: '77', isCorrect: false),
  ]),
  Question(text: 'ปีนี้ยายอายุ 60 ปี หลานอายุ 12 ปี อีกกี่ปี อายุยายจะเป็น 3 เท่าของอายุหลาน', options: [
    const Option(text: '11', isCorrect: false),
    const Option(text: '12', isCorrect: true),
    const Option(text: '13', isCorrect: false),
    const Option(text: '14', isCorrect: false),
  ]),
  Question(text: 'ถ้านำจำนวนเต็ม 3 จำนวนมาบวกกันทีละคู่จะได้ผลบวกเป็น 4, 16 และ 26 จงหาจำนวนที่มากที่สุด', options: [
    const Option(text: '18', isCorrect: false),
    const Option(text: '20', isCorrect: false),
    const Option(text: '30', isCorrect: false),
    const Option(text: '19', isCorrect: true),
  ]),
  Question(text: 'มาลีทำข้อสอบ 24 ข้อ โดยทำถูกมากกว่าผิด 6 ข้อ มาลีทำข้อสอบถูกกี่ข้อ', options: [
    const Option(text: '16', isCorrect: false),
    const Option(text: '15', isCorrect: true),
    const Option(text: '13', isCorrect: false),
    const Option(text: '14', isCorrect: false),
  ]),
  
];