import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/question_controller.dart';

class Time extends StatelessWidget {
  const Time({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF3F4768),
          ),
          borderRadius: BorderRadius.circular(50)),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          // print(controller.animation!.value);
          return Stack(
            children: [
              LayoutBuilder(
                  builder: (context, constraints) => Container(
                        width: constraints.maxWidth * controller.animation!.value,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.lightGreen,
                              Colors.greenAccent
                            ]),
                            borderRadius: BorderRadius.circular(50)),
                      )),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${(controller.animation!.value * 60).round()} วินาที"),
                      Icon(Icons.alarm)
                    ],
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}