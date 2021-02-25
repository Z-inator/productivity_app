class TimeFunctions {

  String timeToText({int seconds}) {
    String hourStr =
        ((seconds / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    String minutesStr = ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).floor().toString().padLeft(2, '0');
    return '$hourStr:$minutesStr:$secondsStr';
  }
}
