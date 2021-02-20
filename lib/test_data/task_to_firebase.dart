import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/services/tasks_data.dart';

class TaskToFirebase {
  User user;
  TaskToFirebase({this.user});

  List<Map<String, dynamic>> taskData = [
    {
      'taskName': 'enable distributed platforms',
      'status': 'Done',
      'taskTime': 400,
      'dueDate': '2020-08-05T03:11:24Z',
      'projectName': 'Linkbridge'
    },
    {
      'taskName': 'deploy holistic models',
      'status': 'In Progress',
      'taskTime': 253,
      'dueDate': '2020-08-21T14:35:25Z',
      'projectName': 'Thoughtsphere'
    },
    {
      'taskName': 'transition front-end interfaces',
      'status': 'Done',
      'taskTime': 323,
      'dueDate': '2020-08-22T19:42:22Z',
      'projectName': 'Topicblab'
    },
    {
      'taskName': 'expedite value-added communities',
      'status': 'To Do',
      'taskTime': 492,
      'dueDate': '2020-08-21T23:23:33Z',
      'projectName': 'Skimia'
    },
    {
      'taskName': 'visualize mission-critical applications',
      'status': 'In Progress',
      'taskTime': 407,
      'dueDate': '2020-08-03T21:52:10Z',
      'projectName': 'Aimbu'
    },
    {
      'taskName': 'matrix turn-key vortals',
      'status': 'Done',
      'taskTime': 350,
      'dueDate': '2020-11-09T12:49:19Z',
      'projectName': 'Oyondu'
    },
    {
      'taskName': 'utilize innovative solutions',
      'status': 'To Do',
      'taskTime': 236,
      'dueDate': '2020-06-24T16:58:49Z',
      'projectName': 'Plambee'
    },
    {
      'taskName': 'redefine global supply-chains',
      'status': 'To Do',
      'taskTime': 297,
      'dueDate': '2020-02-28T23:12:41Z',
      'projectName': 'Avamm'
    },
    {
      'taskName': 'aggregate B2C e-tailers',
      'status': 'In Progress',
      'taskTime': 230,
      'dueDate': '2020-10-30T23:33:32Z',
      'projectName': 'Skiba'
    },
    {
      'taskName': 'generate virtual functionalities',
      'status': 'To Do',
      'taskTime': 93,
      'dueDate': '2020-12-18T01:42:58Z',
      'projectName': 'Skyble'
    },
    {
      'taskName': 'syndicate open-source relationships',
      'status': 'To Do',
      'taskTime': 328,
      'dueDate': '2020-05-28T00:37:26Z',
      'projectName': 'Linkbridge'
    },
    {
      'taskName': 'strategize 24/7 architectures',
      'status': 'In Progress',
      'taskTime': 500,
      'dueDate': '2020-05-28T18:27:21Z',
      'projectName': 'Thoughtsphere'
    },
    {
      'taskName': 'reintermediate holistic infrastructures',
      'status': 'To Do',
      'taskTime': 461,
      'dueDate': '2020-10-21T05:38:07Z',
      'projectName': 'Topicblab'
    },
    {
      'taskName': 'embrace impactful content',
      'status': 'To Do',
      'taskTime': 480,
      'dueDate': '2020-02-29T06:18:49Z',
      'projectName': 'Skimia'
    },
    {
      'taskName': 'enable scalable schemas',
      'status': 'Done',
      'taskTime': 384,
      'dueDate': '2020-07-29T12:25:01Z',
      'projectName': 'Aimbu'
    },
    {
      'taskName': 'reintermediate one-to-one infomediaries',
      'status': 'In Progress',
      'taskTime': 372,
      'dueDate': '2020-11-07T06:17:08Z',
      'projectName': 'Oyondu'
    },
    {
      'taskName': 'integrate rich web-readiness',
      'status': 'Done',
      'taskTime': 443,
      'dueDate': '2020-12-23T04:14:55Z',
      'projectName': 'Plambee'
    },
    {
      'taskName': 'whiteboard global channels',
      'status': 'To Do',
      'taskTime': 76,
      'dueDate': '2021-01-22T09:12:04Z',
      'projectName': 'Avamm'
    },
    {
      'taskName': 'enable world-class deliverables',
      'status': 'Done',
      'taskTime': 245,
      'dueDate': '2020-09-27T18:00:46Z',
      'projectName': 'Skiba'
    },
    {
      'taskName': 'transform holistic paradigms',
      'status': 'To Do',
      'taskTime': 177,
      'dueDate': '2020-12-28T05:51:08Z',
      'projectName': 'Skyble'
    },
    {
      'taskName': 'optimize open-source portals',
      'status': 'To Do',
      'taskTime': 141,
      'dueDate': '2021-01-26T21:05:38Z',
      'projectName': 'Linkbridge'
    },
    {
      'taskName': 'architect cutting-edge initiatives',
      'status': 'To Do',
      'taskTime': 339,
      'dueDate': '2020-09-17T15:57:06Z',
      'projectName': 'Thoughtsphere'
    },
    {
      'taskName': 'implement sexy technologies',
      'status': 'To Do',
      'taskTime': 19,
      'dueDate': '2021-01-06T00:30:39Z',
      'projectName': 'Topicblab'
    },
    {
      'taskName': 'envisioneer open-source supply-chains',
      'status': 'To Do',
      'taskTime': 229,
      'dueDate': '2020-03-06T12:24:28Z',
      'projectName': 'Skimia'
    },
    {
      'taskName': 'integrate web-enabled interfaces',
      'status': 'To Do',
      'taskTime': 373,
      'dueDate': '2020-08-01T05:00:08Z',
      'projectName': 'Aimbu'
    },
    {
      'taskName': 'maximize transparent synergies',
      'status': 'To Do',
      'taskTime': 101,
      'dueDate': '2020-11-18T01:49:00Z',
      'projectName': 'Oyondu'
    },
    {
      'taskName': 'redefine extensible experiences',
      'status': 'In Progress',
      'taskTime': 398,
      'dueDate': '2020-04-19T19:40:42Z',
      'projectName': 'Plambee'
    },
    {
      'taskName': 'streamline efficient web-readiness',
      'status': 'In Progress',
      'taskTime': 447,
      'dueDate': '2020-06-14T04:01:46Z',
      'projectName': 'Avamm'
    },
    {
      'taskName': 'e-enable efficient supply-chains',
      'status': 'Done',
      'taskTime': 221,
      'dueDate': '2021-02-17T13:48:47Z',
      'projectName': 'Skiba'
    },
    {
      'taskName': 'transform one-to-one functionalities',
      'status': 'To Do',
      'taskTime': 62,
      'dueDate': '2021-02-08T18:45:30Z',
      'projectName': 'Skyble'
    },
    {
      'taskName': 'empower customized solutions',
      'status': 'To Do',
      'taskTime': 446,
      'dueDate': '2020-10-27T08:27:18Z',
      'projectName': 'Linkbridge'
    },
    {
      'taskName': 'drive mission-critical mindshare',
      'status': 'In Progress',
      'taskTime': 457,
      'dueDate': '2020-08-23T17:53:31Z',
      'projectName': 'Thoughtsphere'
    },
    {
      'taskName': 'synthesize back-end e-business',
      'status': 'Done',
      'taskTime': 460,
      'dueDate': '2021-02-27T00:43:43Z',
      'projectName': 'Topicblab'
    },
    {
      'taskName': 'morph bleeding-edge synergies',
      'status': 'In Progress',
      'taskTime': 437,
      'dueDate': '2020-12-20T00:02:17Z',
      'projectName': 'Skimia'
    },
    {
      'taskName': 'synthesize e-business eyeballs',
      'status': 'Done',
      'taskTime': 376,
      'dueDate': '2020-12-19T14:58:11Z',
      'projectName': 'Aimbu'
    },
    {
      'taskName': 'maximize bleeding-edge e-markets',
      'status': 'In Progress',
      'taskTime': 414,
      'dueDate': '2020-12-20T07:07:54Z',
      'projectName': 'Oyondu'
    },
    {
      'taskName': 'engineer magnetic e-business',
      'status': 'To Do',
      'taskTime': 489,
      'dueDate': '2020-03-31T15:32:44Z',
      'projectName': 'Plambee'
    },
    {
      'taskName': 'target back-end web-readiness',
      'status': 'To Do',
      'taskTime': 179,
      'dueDate': '2020-09-27T09:02:05Z',
      'projectName': 'Avamm'
    },
    {
      'taskName': 'drive killer metrics',
      'status': 'To Do',
      'taskTime': 303,
      'dueDate': '2021-01-20T10:48:52Z',
      'projectName': 'Skiba'
    },
    {
      'taskName': 'innovate interactive systems',
      'status': 'Done',
      'taskTime': 64,
      'dueDate': '2020-02-25T10:01:51Z',
      'projectName': 'Skyble'
    },
    {
      'taskName': 'iterate virtual ROI',
      'status': 'In Progress',
      'taskTime': 273,
      'dueDate': '2020-11-19T05:31:36Z',
      'projectName': 'Linkbridge'
    },
    {
      'taskName': 'leverage real-time technologies',
      'status': 'Done',
      'taskTime': 498,
      'dueDate': '2020-12-10T11:20:36Z',
      'projectName': 'Thoughtsphere'
    },
    {
      'taskName': 'enable viral action-items',
      'status': 'To Do',
      'taskTime': 293,
      'dueDate': '2020-04-24T22:45:29Z',
      'projectName': 'Topicblab'
    },
    {
      'taskName': 'evolve rich web-readiness',
      'status': 'To Do',
      'taskTime': 301,
      'dueDate': '2020-04-19T12:45:03Z',
      'projectName': 'Skimia'
    },
    {
      'taskName': 'innovate global models',
      'status': 'In Progress',
      'taskTime': 367,
      'dueDate': '2021-02-27T11:51:56Z',
      'projectName': 'Aimbu'
    },
    {
      'taskName': 'unleash plug-and-play bandwidth',
      'status': 'Done',
      'taskTime': 493,
      'dueDate': '2020-08-18T20:31:39Z',
      'projectName': 'Oyondu'
    },
    {
      'taskName': 'cultivate out-of-the-box infrastructures',
      'status': 'To Do',
      'taskTime': 135,
      'dueDate': '2020-10-14T21:40:03Z',
      'projectName': 'Plambee'
    },
    {
      'taskName': 'transition global paradigms',
      'status': 'To Do',
      'taskTime': 435,
      'dueDate': '2021-01-19T21:39:15Z',
      'projectName': 'Avamm'
    },
    {
      'taskName': 'aggregate integrated experiences',
      'status': 'In Progress',
      'taskTime': 113,
      'dueDate': '2020-04-22T14:44:24Z',
      'projectName': 'Skiba'
    },
    {
      'taskName': 'aggregate one-to-one supply-chains',
      'status': 'Done',
      'taskTime': 83,
      'dueDate': '2020-04-22T22:41:30Z',
      'projectName': 'Skyble'
    }
  ];

  Future<void> uploadExampleData() async {
    for (Map<String, dynamic> map in taskData) {
      TaskService(user: user)
          .addTask(
              taskName: map['taskName'],
              status: map['status'],
              taskTime: map['taskTime'],
              dueDate: DateTime.parse(map['dueDate']),
              projectName: map['projectName'])
          .then((value) => print(value.id));
      print('Added task');
    }
  }
}
