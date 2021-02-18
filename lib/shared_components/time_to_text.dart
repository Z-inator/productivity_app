
class TimerText {
  final int ticks;

  TimerText({this.ticks});

  List<String> getTimerText() {
    String hourStr =
        ((ticks / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    String minutesStr = ((ticks / 60) % 60).floor().toString().padLeft(2, '0');
    String secondsStr = (ticks % 60).floor().toString().padLeft(2, '0');
    return [hourStr, minutesStr, secondsStr];
  }
}
