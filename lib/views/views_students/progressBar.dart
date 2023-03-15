import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/question.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xF3F4768) , width: 3),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Stack(children: [
            LayoutBuilder(
              builder: (context, constraints) => Container(
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.lightGreen ,Colors.greenAccent]),
                  borderRadius: BorderRadius.circular(50)
                ),
              )),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("30 sec"),
                      Icon(Icons.alarm)
                    ],
                  ),
                ) )
          ]
      )
    );
  }
}