import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/question.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key, required this.seconds,
  });

   final int seconds;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {

  late int _secondsRemaining;
  late Timer _timer;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.seconds;
   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  setState(() {
    _secondsRemaining--;
    if(_secondsRemaining == 0) {
      _timer.cancel();
      _isLocked = true;
    }
  });
});
  }

 @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  String get timerText {
    Duration duration = Duration(seconds: _secondsRemaining);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    double progress = _secondsRemaining / widget.seconds;
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xF3F4768) , width: 3),
          borderRadius: BorderRadius.circular(50)
        ),
        child: Stack(children: [
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  width: progress,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.lightGreen ,Colors.greenAccent]),
                    borderRadius: BorderRadius.circular(50)
                  ),
                )),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(timerText),
                        const Icon(Icons.alarm)
                      ],
                    ),
                  ) )
            ]
        )
      ),
    );
  }
}