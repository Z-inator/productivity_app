
class Subtasks {
  String subtaskName;
  bool isDone = false;

  Subtasks({this.subtaskName});

  void toggleDone() {
    isDone = !isDone;
  }
}
