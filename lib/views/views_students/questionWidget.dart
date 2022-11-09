import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_project/models/question.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({super.key});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 232, 23),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo.png'),
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'QUIZZZ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Text(
                  '$_questionNumber/${questions.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade200,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 10,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color.fromARGB(255, 47, 237, 53)),
                ),
              ],
            ),
            Expanded(
                child: PageView.builder(
                    itemCount: questions.length,
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final _question = questions[index];
                      return buildQuestion(_question);
                    })),
            _isLocked ? buildElevatedButton() : const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Container(
          alignment: Alignment.center,
          height: 180,
          width: 500,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Text(
              question.text,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Expanded(
            child: OptionsWidget(
                question: question,
                onClickedOption: (option) {
                  if (question.isLocked) {
                    return;
                  } else {
                    setState(() {
                      question.isLocked = true;
                      question.selectedOption = option;
                    });
                    _isLocked = question.isLocked;
                    if (question.selectedOption!.isCorrect) {
                      _score++;
                    }
                  }
                }))
      ],
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          if (_questionNumber < questions.length) {
            _controller.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInExpo);
            setState(() {
              _questionNumber++;
              _isLocked = false;
            });
          } else {
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ResultPage(score: _score)));

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ResultPage(score: _score);
                });
          }
        },
        child: Text(_questionNumber < questions.length
            ? 'Next Page'
            : 'See the Result'));
  }
}

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .map((option) => buildOption(context, option))
              .toList(),
        ),
      );

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option.text,
              style: TextStyle(fontSize: 20),
            ),
            getIconForOption(option, question),
          ],
        ),
      ),
    );
  }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? Color.fromARGB(255, 47, 237, 53) : Colors.red;
      } else if (option.isCorrect) {
        return Color.fromARGB(255, 47, 237, 53);
      }
    }
    return Colors.grey.shade300;
  }

  Widget getIconForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect
            ? const Icon(
                Icons.check_circle,
                color: Color.fromARGB(255, 47, 237, 53),
              )
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              );
      } else if (option.isCorrect) {
        return const Icon(
          Icons.check_circle,
          color: Color.fromARGB(255, 47, 237, 53),
        );
      }
    }
    return const SizedBox.shrink();
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFF23232b),
      title: AnimatedPositioned(
        duration: Duration(milliseconds: 2),
        curve: Curves.decelerate,
        bottom: 5,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          // height: MediaQuery.of(context).size.height * 0.50,
          // width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: Color(0xFFF23232b),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Text(
                'You Score $score/${questions.length}',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentRanking()));
                  },
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 50,
                    color: Colors.yellow,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class StudentRanking extends StatelessWidget {
  const StudentRanking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ranking', style: TextStyle(fontSize: 30),) ,
        backgroundColor: Color(0xFFF23232b),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.exit_to_app))
        ],
      ),
      backgroundColor: Color(0xFFF23232b),
      body: Center(
          child: Column(
        children: [
          // Text(
          //   'ranking',
          //   style: TextStyle(color: Colors.white, fontSize: 30),
          // ),
          Container(
            margin: EdgeInsets.all(20),
            height: 150,
            width: 500,
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/146/146005.png?w=360')),
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Name : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Pailin')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Point : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('5')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Ranking : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('1')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: 350,
            width: 400,
            color: Colors.amber,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rank',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'Points',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            buildStudentLists(
                                1, Icons.face_sharp, 'Pailin', 5),
                            buildStudentLists(2, Icons.face_sharp, 'Sea', 4),
                            buildStudentLists(3, Icons.face_sharp, 'Pond', 3),
                            buildStudentLists(
                                4, Icons.face_sharp, 'UserName 1', 2),
                            buildStudentLists(
                                5, Icons.face_sharp, 'UserName 1', 0),
                            buildStudentLists(
                                6, Icons.face_sharp, 'UserName 1', 0),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Container buildStudentLists(
      int number, IconData icon, String title, int amount) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$number',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    '$amount',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
