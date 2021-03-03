import 'package:productivity_app/services/times_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TimeToFirebase {
  User user;
  TimeToFirebase({this.user});

  List<Map<String, dynamic>> timeData = [
    {"elapsedTime":40,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"revolutionize visionary eyeballs","projectName":"BlogXS"},
    {"elapsedTime":65,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"harness B2B web services","projectName":"Dabfeed"},
    {"elapsedTime":91,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"productize real-time channels","projectName":"Agimba"},
    {"elapsedTime":69,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"engineer synergistic deliverables","projectName":"Devcast"},
    {"elapsedTime":20,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"syndicate customized vortals","projectName":"Janyx"},
    {"elapsedTime":52,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"enable web-enabled methodologies","projectName":"Feedmix"},
    {"elapsedTime":30,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"monetize best-of-breed architectures","projectName":"Tazz"},
    {"elapsedTime":56,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"monetize seamless convergence","projectName":"Trupe"},
    {"elapsedTime":22,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"visualize e-business bandwidth","projectName":"Cogilith"},
    {"elapsedTime":96,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"deliver open-source networks","projectName":"Yodoo"}
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
