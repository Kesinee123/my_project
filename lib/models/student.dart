class StudentFields {
  static final String id = 'ลำดับ';
  static final String name = 'ชื่อ - นามสกุล';
  // static final String email = 'อีเมล';
  static final String quizTitle = 'ชื่อแบบทดสอบ';
  static final String quizsubject = 'วิชา';
  // static final String makeQuizStart = 'เวลาที่เริ่มทำแบบทดสอบ';
  // static final String makeQuizEnd = 'เวลาที่ทำแบบทดสอบเสร็จ';
  static final String score = 'คะแนน';
  static final String status = 'ประเภทการทำแบบทดสอบ';

  static List<String> getFields() => [id,name,quizTitle,quizsubject,score,status];
}

// class StudentFieldsHomeWork {
//   static final String id = 'ลำดับ';
//   static final String name = 'ชื่อ - นามสกุล';
//   // static final String email = 'อีเมล';
//   static final String quizTitle = 'ชื่อแบบทดสอบ';
//   static final String quizsubject = 'วิชา';
//   static final String makeQuizStart = 'เวลาที่เริ่มทำแบบทดสอบ';
//   static final String makeQuizEnd = 'เวลาที่ทำแบบทดสอบเสร็จ';
//   static final String score = 'คะแนน';
//   static final String typeQuiz = 'ประเภทการทำแบบทดสอบ';

//   static List<String> getFieldsHW() => [id,name,quizTitle,quizsubject,makeQuizStart,makeQuizEnd,score,typeQuiz];
// }