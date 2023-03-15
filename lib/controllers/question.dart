// // ignore_for_file: deprecated_member_use



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:my_project/models/question.dart';
// import 'package:my_project/views/views_students/score.dart';

// class QuestionController extends GetxController

// with SingleGetTickerProviderMixin {

//   AnimationController? _animationController;
//   Animation? _animation;

//   Animation? get animation => this._animation;

//   PageController? _pageController;
//   PageController get pageController => this._pageController!;

//   List<Question> _questions = sample_data.map((question) => Question(
//     id: question['id'],
//     question: question['question'],
//     options: question['options'],
//     correct_answer: question['correct_answer'],
//     )).toList();

//     List<Question> get questions => this._questions;

//     bool _isAnswer = false;
//     bool get isAnswer => this._isAnswer;

//     int? _correctAns;
//     int? get correctAns => this._correctAns;

//     int? _selectedAns;
//     int? get selectedAns => this._selectedAns;

//     RxInt _questionNumber = 1.obs;
//     RxInt get questionNumber => this._questionNumber;

//     late int _numOfCorrectAns;
//     int get numOfCorrectAns => this._numOfCorrectAns;

//   @override
//   void onInit() {
//     _animationController = AnimationController(duration: Duration(seconds: 30) ,vsync: this);
//     _animation = Tween<double>(begin: 0 , end: 1 ).animate(_animationController!)
//     ..addListener(() {
//       update();
//     });

//     // start our animation
//     _animationController!.forward().whenComplete(nextQueation);

//     _pageController = PageController();

//     super.onInit();
//   } 

//   @override
//   void onClose() {
//     super.onClose();
//     _animationController!.dispose();
//     _pageController!.dispose();
//   }

//   void checkAns(Question question , int selectedIndex) {
//     _isAnswer = true;
//     _correctAns = question.correct_answer;
//     _selectedAns = selectedIndex;

//     if(_correctAns == _selectedAns) _numOfCorrectAns++;

//     _animationController!.stop();
//     update();

//     Future.delayed(Duration(seconds: 3), () {
//       nextQueation();
//     });
//   }
//   void nextQueation() {
//     if(_questionNumber.value != _questions.length){
//       _isAnswer = false;
//       _pageController?.nextPage(duration: Duration(milliseconds: 250), curve: Curves.ease);

//       _animationController!.reset();

//       _animationController!.forward().whenComplete(nextQueation);
//     } else {
//       Get.to(Score());
//     }

    
//   }
//   void updateTheQrNum(int index) {
//     _questionNumber.value = index + 1 ;
//   }
// }
