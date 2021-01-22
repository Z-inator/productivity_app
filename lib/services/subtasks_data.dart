import 'package:productivity_app/models/subtasks.dart';
import 'package:productivity_app/models/tasks.dart';

class SubtaskData {
  void addSubtask(Tasks task, String newSubtaskName) {
    final newSubtask = Subtasks(subtaskName: newSubtaskName);
    task.subtasks.add(newSubtask);
  }

  void updateSubtaskName(Subtasks subtaskName, String updateSubtaskName) {
    subtaskName.subtaskName = updateSubtaskName;
  }

  void updateSubtask(Subtasks subtask) {
    subtask.toggleDone();
  }

  void deleteSubtask(Tasks task, Subtasks subtask) {
    task.subtasks.remove(subtask);
  }
}
