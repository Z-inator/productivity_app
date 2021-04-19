import 'package:flutter/material.dart';

class TimeFunctions {
  String timeToText({int seconds}) {
    final String hourStr =
        (seconds / (60 * 60)).floor().toString().padLeft(2, '0');
    final String minutesStr =
        ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).floor().toString().padLeft(2, '0');
    return '$hourStr:$minutesStr:$secondsStr';
  }

  // String timeOfDayToText({TimeOfDay time, BuildContext context}) {
  //   return time.format(context);
  // }

  String timeToTextWithoutSeconds({int seconds}) {
    final String hourStr =
        ((seconds / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    final String minutesStr =
        ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
    return '$hourStr:$minutesStr';
  }

  String timeToTextHours({int seconds}) {
    return ((seconds / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
  }

  String timeToTextMinutes({int seconds}) {
    return ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
  }

  String timeToTextSeconds({int seconds}) {
    return (seconds % 60).floor().toString().padLeft(2, '0');
  }
}
