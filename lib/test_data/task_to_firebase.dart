// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'Task_Feature/services/projects_data.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'Task_Feature/services/tasks_data.dart';

// class TaskToFirebase {

//   List<Map<String, dynamic>> taskData = [
//     {"taskName":"incentivize proactive convergence","status":"To Do","taskTime":591,"dueDate":"2021-01-08T21:19:35Z","createDate":"2020-07-07T00:11:33Z","projectName":"Linkbridge"},
//     {"taskName":"cultivate robust e-tailers","status":"Done","taskTime":237,"dueDate":"2021-01-30T00:43:37Z","createDate":"2020-08-11T06:40:42Z","projectName":"Thoughtsphere"},
//     {"taskName":"implement next-generation synergies","status":"To Do","taskTime":107,"dueDate":"2021-03-10T20:24:09Z","createDate":"2020-09-19T10:11:39Z","projectName":"Topicblab"},
//     {"taskName":"productize impactful solutions","status":"To Do","taskTime":610,"dueDate":"2021-01-18T21:10:18Z","createDate":"2020-07-01T11:03:42Z","projectName":"Skimia"},
//     {"taskName":"redefine rich e-tailers","status":"Done","taskTime":579,"dueDate":"2021-02-19T14:53:37Z","createDate":"2020-08-10T13:56:03Z","projectName":"Aimbu"},
//     {"taskName":"empower distributed vortals","status":"To Do","taskTime":481,"dueDate":"2021-01-07T15:34:08Z","createDate":"2020-11-29T16:00:30Z","projectName":"Oyondu"},
//     {"taskName":"embrace magnetic interfaces","status":"Archived","taskTime":671,"dueDate":"2021-01-02T14:00:17Z","createDate":"2020-08-27T01:53:07Z","projectName":"Plambee"},
//     {"taskName":"scale turn-key deliverables","status":"To Do","taskTime":816,"dueDate":"2021-02-04T06:48:48Z","createDate":"2020-09-16T11:13:44Z","projectName":"Avamm"},
//     {"taskName":"matrix world-class convergence","status":"To Do","taskTime":532,"dueDate":"2021-03-09T13:27:48Z","createDate":"2020-08-02T11:23:16Z","projectName":"Skiba"},
//     {"taskName":"repurpose rich e-services","status":"Done","taskTime":612,"dueDate":"2021-03-06T21:18:59Z","createDate":"2020-08-01T19:52:11Z","projectName":"Skyble"},
//     {"taskName":"drive B2C vortals","status":"Done","taskTime":660,"dueDate":"2021-03-29T04:55:34Z","createDate":"2020-07-19T20:19:02Z","projectName":"Linkbridge"},
//     {"taskName":"architect leading-edge networks","status":"Archived","taskTime":226,"dueDate":"2021-02-22T08:48:52Z","createDate":"2020-09-24T12:58:42Z","projectName":"Thoughtsphere"},
//     {"taskName":"monetize extensible content","status":"In Progress","taskTime":73,"dueDate":"2021-02-26T20:58:24Z","createDate":"2020-07-03T13:26:39Z","projectName":"Topicblab"},
//     {"taskName":"transform mission-critical metrics","status":"To Do","taskTime":585,"dueDate":"2021-01-03T01:51:10Z","createDate":"2020-09-17T23:27:11Z","projectName":"Skimia"},
//     {"taskName":"target cutting-edge e-commerce","status":"To Do","taskTime":379,"dueDate":"2021-03-02T13:11:15Z","createDate":"2020-08-10T01:13:22Z","projectName":"Aimbu"},
//     {"taskName":"extend value-added e-tailers","status":"Done","taskTime":480,"dueDate":"2021-03-02T19:41:39Z","createDate":"2020-12-22T18:51:14Z","projectName":"Oyondu"},
//     {"taskName":"reintermediate innovative initiatives","status":"Done","taskTime":856,"dueDate":"2021-01-28T19:18:42Z","createDate":"2020-11-13T06:19:03Z","projectName":"Plambee"},
//     {"taskName":"recontextualize dynamic systems","status":"Done","taskTime":622,"dueDate":"2021-02-07T20:50:23Z","createDate":"2020-12-04T09:34:19Z","projectName":"Avamm"},
//     {"taskName":"exploit open-source e-tailers","status":"Done","taskTime":794,"dueDate":"2021-01-16T19:46:59Z","createDate":"2020-11-01T17:32:23Z","projectName":"Skiba"},
//     {"taskName":"strategize sexy solutions","status":"To Do","taskTime":590,"dueDate":"2021-01-30T16:18:19Z","createDate":"2020-10-03T06:54:22Z","projectName":"Skyble"},
//     {"taskName":"grow wireless models","status":"Archived","taskTime":18,"dueDate":"2021-03-19T06:21:35Z","createDate":"2020-07-15T13:21:28Z","projectName":"Linkbridge"},
//     {"taskName":"whiteboard clicks-and-mortar synergies","status":"Done","taskTime":473,"dueDate":"2021-02-21T17:20:21Z","createDate":"2020-07-28T20:07:35Z","projectName":"Thoughtsphere"},
//     {"taskName":"leverage interactive schemas","status":"In Progress","taskTime":665,"dueDate":"2021-03-05T05:04:46Z","createDate":"2020-10-09T19:04:19Z","projectName":"Topicblab"},
//     {"taskName":"facilitate open-source infomediaries","status":"Done","taskTime":34,"dueDate":"2021-03-13T04:17:33Z","createDate":"2020-08-05T12:12:53Z","projectName":"Skimia"},
//     {"taskName":"morph cross-platform paradigms","status":"To Do","taskTime":503,"dueDate":"2021-01-26T08:47:21Z","createDate":"2020-08-10T05:04:36Z","projectName":"Aimbu"},
//     {"taskName":"scale cutting-edge e-business","status":"Done","taskTime":417,"dueDate":"2021-01-15T01:34:27Z","createDate":"2020-11-16T15:30:25Z","projectName":"Oyondu"},
//     {"taskName":"redefine dynamic synergies","status":"Archived","taskTime":779,"dueDate":"2021-01-14T02:17:40Z","createDate":"2020-09-28T05:24:28Z","projectName":"Plambee"},
//     {"taskName":"morph real-time web-readiness","status":"To Do","taskTime":229,"dueDate":"2021-01-17T04:12:35Z","createDate":"2020-08-17T13:43:12Z","projectName":"Avamm"},
//     {"taskName":"expedite cutting-edge initiatives","status":"Done","taskTime":269,"dueDate":"2021-02-12T01:45:33Z","createDate":"2020-12-24T03:12:23Z","projectName":"Skiba"},
//     {"taskName":"maximize seamless convergence","status":"Done","taskTime":495,"dueDate":"2021-01-05T17:07:23Z","createDate":"2020-07-12T06:53:35Z","projectName":"Skyble"},
//     {"taskName":"maximize cross-media functionalities","status":"In Progress","taskTime":154,"dueDate":"2021-03-28T20:34:17Z","createDate":"2020-09-05T03:41:26Z","projectName":"Linkbridge"},
//     {"taskName":"reintermediate user-centric applications","status":"In Progress","taskTime":481,"dueDate":"2021-01-26T06:59:46Z","createDate":"2020-11-17T08:17:03Z","projectName":"Thoughtsphere"},
//     {"taskName":"mesh value-added systems","status":"Archived","taskTime":71,"dueDate":"2021-01-02T15:00:19Z","createDate":"2020-08-25T06:31:03Z","projectName":"Topicblab"},
//     {"taskName":"scale turn-key networks","status":"To Do","taskTime":21,"dueDate":"2021-01-04T01:50:14Z","createDate":"2020-12-10T22:23:10Z","projectName":"Skimia"},
//     {"taskName":"synergize efficient relationships","status":"In Progress","taskTime":838,"dueDate":"2021-01-14T08:53:53Z","createDate":"2020-07-21T16:07:46Z","projectName":"Aimbu"},
//     {"taskName":"leverage 24/7 channels","status":"To Do","taskTime":1,"dueDate":"2021-01-13T10:20:46Z","createDate":"2020-07-22T09:43:50Z","projectName":"Oyondu"},
//     {"taskName":"synergize mission-critical technologies","status":"In Progress","taskTime":530,"dueDate":"2021-03-25T01:25:00Z","createDate":"2020-09-16T00:38:51Z","projectName":"Plambee"},
//     {"taskName":"grow granular web services","status":"Done","taskTime":324,"dueDate":"2021-03-16T13:43:48Z","createDate":"2020-07-15T02:01:15Z","projectName":"Avamm"},
//     {"taskName":"integrate ubiquitous partnerships","status":"Archived","taskTime":905,"dueDate":"2021-01-16T04:09:16Z","createDate":"2020-08-07T18:34:46Z","projectName":"Skiba"},
//     {"taskName":"deliver user-centric vortals","status":"To Do","taskTime":745,"dueDate":"2021-02-03T08:54:53Z","createDate":"2020-09-29T16:15:04Z","projectName":"Skyble"},
//     {"taskName":"incubate next-generation models","status":"Done","taskTime":640,"dueDate":"2021-02-20T02:00:42Z","createDate":"2020-07-01T18:55:06Z","projectName":"Linkbridge"},
//     {"taskName":"incentivize open-source web-readiness","status":"In Progress","taskTime":655,"dueDate":"2021-01-25T14:43:49Z","createDate":"2020-09-13T20:00:57Z","projectName":"Thoughtsphere"},
//     {"taskName":"orchestrate leading-edge e-commerce","status":"Archived","taskTime":838,"dueDate":"2021-01-25T12:41:48Z","createDate":"2020-10-25T05:39:07Z","projectName":"Topicblab"},
//     {"taskName":"redefine impactful eyeballs","status":"To Do","taskTime":656,"dueDate":"2021-01-28T19:28:26Z","createDate":"2020-10-10T04:07:10Z","projectName":"Skimia"},
//     {"taskName":"disintermediate value-added networks","status":"To Do","taskTime":494,"dueDate":"2021-01-26T04:59:37Z","createDate":"2020-09-27T21:26:04Z","projectName":"Aimbu"},
//     {"taskName":"mesh bleeding-edge relationships","status":"Archived","taskTime":794,"dueDate":"2021-03-27T03:04:34Z","createDate":"2020-09-15T10:08:36Z","projectName":"Oyondu"},
//     {"taskName":"transform robust niches","status":"Done","taskTime":588,"dueDate":"2021-02-17T02:46:51Z","createDate":"2020-11-23T15:59:35Z","projectName":"Plambee"},
//     {"taskName":"cultivate user-centric platforms","status":"Archived","taskTime":42,"dueDate":"2021-01-14T22:33:08Z","createDate":"2020-12-09T09:46:23Z","projectName":"Avamm"},
//     {"taskName":"reintermediate integrated platforms","status":"Done","taskTime":580,"dueDate":"2021-01-02T06:30:03Z","createDate":"2020-12-05T07:57:06Z","projectName":"Skiba"},
//     {"taskName":"unleash dynamic e-commerce","status":"To Do","taskTime":46,"dueDate":"2021-03-26T12:21:02Z","createDate":"2020-10-11T23:18:34Z","projectName":"Skyble"}];

//   Future<void> uploadExampleData() async {
//     for (final Map<String, dynamic> map in taskData) {
//       TaskService()
//           .addTask(
//               taskName: map['taskName'].toString(),
//               status: map['status'].toString(),
//               taskTime: map['taskTime'] as int,
//               dueDate: DateTime.parse(map['dueDate'].toString()),
//               projectName: map['projectName'].toString(),
//               createDate: DateTime.parse(map['createDate'].toString()))
//           .then((value) => print(value.id));
//       print('Added task');
//     }
//   }
// }

