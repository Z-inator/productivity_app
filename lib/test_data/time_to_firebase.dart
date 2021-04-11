// import 'package:productivity_app/Time_Feature/services/times_data.dart';

// class TimeToFirebase {
//   List<Map<String, dynamic>> data = [
//     {"elapsedTime":27,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"architect rich web services","projectName":"Skimia"},
//     {"elapsedTime":43,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"deliver strategic experiences","projectName":"Oyondu"},
//     {"elapsedTime":58,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"productize killer ROI","projectName":"Linkbridge"},
//     {"elapsedTime":2,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"incentivize clicks-and-mortar eyeballs","projectName":"Avamm"},
//     {"elapsedTime":32,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"innovate compelling infrastructures","projectName":"Topicblab"},
//     {"elapsedTime":7,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"e-enable out-of-the-box vortals","projectName":"Plambee"},
//     {"elapsedTime":69,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"syndicate plug-and-play systems","projectName":"Aimbu"},
//     {"elapsedTime":24,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"visualize seamless e-tailers","projectName":"Linkbridge"},
//     {"elapsedTime":45,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"target virtual solutions","projectName":"Skiba"},
//     {"elapsedTime":97,"startTime":"2020-03-20T00:00:00Z","endTime":"2020-03-20T00:00:00Z","entryName":"synergize clicks-and-mortar architectures","projectName":"Avamm"}];


//   Future<void> uploadExampleData() {
//     for (final Map<String, dynamic> map in data) {
//       final Map<String, dynamic> data = {
//         'entryName': map['entryName'].toString(),
//         'projectName': map['projectName'],
//         'startTime': DateTime.parse(map['startTime'] as String),
//         'endTime': DateTime.parse(map['endTime'] as String),
//         'elapsedTime': map['elapsedTime'] as int
//       };
//       TimeService().addTimeEntry(addData: data);
//     }
//   }
// }
