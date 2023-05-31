import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/models/option.dart';
import 'package:my_project/views/views_students/score1.dart';

import '../models/question.dart';

class QuestionController extends GetxController with SingleGetTickerProviderMixin {
  AnimationController? _animationController;
  Animation? _animation;

  Animation? get animation => this._animation;

  PageController? _pageController;
  PageController? get pageController => this._pageController;

  bool _isLocked = false;
  bool get isLocked => this._isLocked;

  int? _selectedAns;
  int? get selectedAns => this._selectedAns;

  String? _correct_answer;
  String? get correct_answer => this._correct_answer;

  String? _identifier;
  String? get identifier => this._identifier;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  late int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  @override
  void onInit() {
    _animationController = AnimationController(
      duration: Duration(seconds: 60),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        update();
      });

    _animationController!.forward();
    _pageController = PageController();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController!.dispose();
    _pageController!.dispose();
  }

  void checkAns(
    Question question,
    List<Option> option,
    int selectedIndex,
    int length,
  ) {
    _isLocked = true;
    _correct_answer = question.correct_answer;
    _selectedAns = selectedIndex;
    _identifier = option[selectedIndex].identifier;

    if (_correct_answer == _identifier) _numOfCorrectAns++;

    print('correct answer: $_correct_answer, selected answer: $_identifier');

    _animationController!.stop();
    update();

    Future.delayed(Duration(seconds: 3), () {
      nextQuestion(length);
    });
  }

  void nextQuestion(int length) {
    if (_questionNumber.value != length) {
      _isLocked = false;
      _pageController?.nextPage(
        duration: Duration(milliseconds: 250),
        curve: Curves.ease,
      );

      _animationController!.reset();

      _animationController!.forward().whenComplete(() => nextQuestion(length));
    } else {
      Get.to(Score1());
    }
  }

  void updateTheQsNum(int index) {
    _questionNumber.value = index + 1;
  }
}
