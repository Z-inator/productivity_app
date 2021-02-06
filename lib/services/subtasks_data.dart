// import 'package:productivity_app/models/subtasks.dart';
// import 'package:productivity_app/models/tasks.dart';
// import 'globals.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// class SubtaskService {
//   // Collection reference
//   final CollectionReference subtasksReference = FirebaseFirestore.instance
//       .collection('users')
//       .doc(Global().user.uid)
//       .collection('subtasks');

//   // Add Subtask
//   Future<void> addSubtask(String subtaskName) async {
//     return await subtasksReference
//         .add({'subtaskName': subtaskName, 'isDone': false})
//         .then((value) => print('Subtask Added'))
//         .catchError((error) => print('Failed to add subtask: $error'));
//   }

//   // Update Subtask
//   Future<void> updateSubtask(
//       String subtaskID, String subtaskName, bool isDone) async {
//     return await subtasksReference
//         .doc(subtaskID)
//         .set({'subtaskName': subtaskName, 'isDone': isDone});
//   }

//   // Delete Subtask
//   Future<void> deleteSubtask(String subtaskID) async {
//     return subtasksReference
//         .doc(subtaskID)
//         .delete()
//         .then((value) => print('Subtask Deleted'))
//         .catchError((error) => print('Failed to delete subtask: $error'));
//   }

//   // subtask Collections Stream
//   Stream<QuerySnapshot> get subtasksCollection {
//     return subtasksReference.snapshots();
//   }
// }


// class SubtaskData {
//   void addSubtask(Tasks task, String newSubtaskName) {
//     final newSubtask = Subtasks(subtaskName: newSubtaskName);
//     task.subtasks.add(newSubtask);
//   }

//   void updateSubtaskName(Subtasks subtaskName, String updateSubtaskName) {
//     subtaskName.subtaskName = updateSubtaskName;
//   }

//   void updateSubtask(Subtasks subtask) {
//     subtask.toggleDone();
//   }

//   void deleteSubtask(Tasks task, Subtasks subtask) {
//     task.subtasks.remove(subtask);
//   }
// }
