import '../../Task_Feature/Task_Feature.dart';

class Subtask {
  String subtaskID = '';
  String? subtaskName;
  Task task = Task();
  bool isDone = false;

  Subtask({this.subtaskName});

  void toggleDone() {
    isDone = !isDone;
  }
}
