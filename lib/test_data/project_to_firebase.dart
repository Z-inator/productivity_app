// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:productivity_app/services/projects_data.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:productivity_app/services/tasks_data.dart';

// class ProjectToFirebase {
//   User user;
//   ProjectToFirebase({this.user});

//   List<Map<String, dynamic>> projectData = [
//     {'projectName':'Linkbridge','projectTime':764,'projectColor':13},
//     {'projectName':'Thoughtsphere','projectTime':54,'projectColor':11},
//     {'projectName':'Topicblab','projectTime':676,'projectColor':7},
//     {'projectName':'Skimia','projectTime':146,'projectColor':11},
//     {'projectName':'Aimbu','projectTime':346,'projectColor':11},
//     {'projectName':'Oyondu','projectTime':55,'projectColor':1},
//     {'projectName':'Plambee','projectTime':658,'projectColor':8},
//     {'projectName':'Avamm','projectTime':583,'projectColor':18},
//     {'projectName':'Skiba','projectTime':790,'projectColor':2},
//     {'projectName':'Skyble','projectTime':621,'projectColor':8},
//   ];

//   Future<void> uploadExampleData() {
//     for (Map<String, dynamic> map in projectData) {
//       ProjectService(user: user).addProject(
//         projectName: map['projectName'].toString(),
//         projectTime: map['projectTime'],
//         projectColor: map['projectColor'],
//       );
//     }
//   }

//   Future<void> updateProjectData() async {
//     Map<String, String> projects = {};
//     await ProjectService(user: user)
//         .projects
//         .get()
//         .then((QuerySnapshot querySnapshot) => {
//               querySnapshot.docs.forEach((doc) {
//                 projects[doc.id] = doc['projectName'].toString();
//               })
//             });
//     projects.forEach((key, value) async {
//       Map<String, String> taskInfo = {};
//       await TaskService(user: user)
//           .tasks
//           .where('projectName', isEqualTo: value)
//           .get()
//           .then((QuerySnapshot querySnapshot) => {
//                 querySnapshot.docs.forEach((doc) {
//                   taskInfo[doc.id] = doc['taskName'].toString();
//                   print(
//                       'projectID: $key projectname: $value ----- taskID: ${doc.id} name: ${doc['taskName']}');
//                 })
//               });
//       ProjectService(user: user).updateProject(projectID: key, updateData: {
//         'taskList': Map.from(taskInfo)
//       }).then((value) => print('project updated'));
//     });
//   }
// }
