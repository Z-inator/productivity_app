import 'package:productivity_app/Task_Feature/models/tasks.dart';

class Subtask {
  String subtaskID = '';
  String subtaskName;
  Task task = Task();
  bool isDone = false;

  Subtask({this.subtaskName});

  void toggleDone() {
    isDone = !isDone;
  }
}
