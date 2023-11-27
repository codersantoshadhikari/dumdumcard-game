import 'package:flutter/material.dart';
import 'dart:async';

class PlayerTimer extends StatefulWidget {

  const PlayerTimer({super.key});

  @override
  State<PlayerTimer> createState() => _PlayerTimerState();
}

class _PlayerTimerState extends State<PlayerTimer> {
  int limit = 60;
  int playerTime = 0;
  bool timerStatus = true;


  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if ((playerTime == limit) || timerStatus == false){
        timer.cancel();
      } else {
        setState(() {
          playerTime++;
        });
      }
    });
  }

  void forceStop(){
    timerStatus = !timerStatus;
    if(timerStatus){
      _startTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    timerStatus = false;
    debugPrint("Timer Stopped");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Column(
    children: [Text(
      'Player Time: $playerTime',
      style: const TextStyle(fontSize: 17),
    ),
    ]);
  }
}