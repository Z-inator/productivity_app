class TimeFunctions {

  String timeToText({int seconds}) {
    String hourStr =
        ((seconds / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    String minutesStr = ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).floor().toString().padLeft(2, '0');
    return '$hourStr:$minutesStr:$secondsStr';
  }

  String timeToTextWithoutSeconds({int seconds}) {
    String hourStr =
        ((seconds / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    String minutesStr = ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
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
