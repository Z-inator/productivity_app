import 'package:flutter/material.dart';


class Timer extends ChangeNotifier {
  String hoursString = '00';
  String minutesString = '00';
  String secondsString = '00';
  int newTick;

    

  String timeToString() {
    hoursString = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    minutesString = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
    secondsString = (newTick % 60).floor().toString().padLeft(2, '0');
    return '$hoursString:$minutesString:$secondsString';
  }

  @override
  Widget build(BuildContext context) {
    return (
      
    );
  }
}