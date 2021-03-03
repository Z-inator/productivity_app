import 'package:productivity_app/services/times_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TimeToFirebase {
  User user;
  TimeToFirebase({this.user});

  List<Map<String, dynamic>> timeData = [
    {"elapsedTime":27,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"architect rich web services","projectName":"Skimia"},
    {"elapsedTime":43,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"deliver strategic experiences","projectName":"Oyondu"},
    {"elapsedTime":58,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"productize killer ROI","projectName":"Linkbridge"},
    {"elapsedTime":2,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"incentivize clicks-and-mortar eyeballs","projectName":"Avamm"},
    {"elapsedTime":32,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"innovate compelling infrastructures","projectName":"Topicblab"},
    {"elapsedTime":7,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"e-enable out-of-the-box vortals","projectName":"Plambee"},
    {"elapsedTime":69,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"syndicate plug-and-play systems","projectName":"Aimbu"},
    {"elapsedTime":24,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"visualize seamless e-tailers","projectName":"Linkbridge"},
    {"elapsedTime":45,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"target virtual solutions","projectName":"Skiba"},
    {"elapsedTime":97,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"synergize clicks-and-mortar architectures","projectName":"Avamm"}
  ];

  Future<void> uploadExampleData() {
    for (Map<String, dynamic> map in timeData) {
      TimeService(user: user).addTimeEntry2(
        addToDate: '05-20-2021',
        addData: map
      );
    }
  }
}
