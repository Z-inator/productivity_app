// import 'dart:async';

// import 'package:flutter/material.dart';

// class Ticker extends StatefulWidget {
//   @override
//   _TickerState createState() => _TickerState();
// }

// class _TickerState extends State<Ticker> {
//   bool flag = true;
//   Stream<int> timerStream;
//   StreamSubscription<int> timerSubscription;
//   String hoursStr = '00';
//   String minutesStr = '00';
//   String secondsStr = '00';

//   Stream<int> stopWatchStream() {
//     StreamController<int> streamController;
//     Timer timer;
//     Duration timerInterval = Duration(seconds: 1);
//     int counter = 0;

//     void stopTimer() {
//       if (timer != null) {
//         timer.cancel();
//         timer = null;
//         counter = 0;
//         streamController.close();
//       }
//     }

//     void tick(_) {
//       counter++;
//       streamController.add(counter);
//       if (!flag) {
//         stopTimer();
//       }
//     }

//     void startTimer() {
//       timer = Timer.periodic(timerInterval, tick);
//     }

//     streamController = StreamController<int>(
//       onListen: startTimer,
//       onCancel: stopTimer,
//       onResume: startTimer,
//       onPause: stopTimer,
//     );

//     return streamController.stream;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Flutter StopWatch")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "$hoursStr:$minutesStr:$secondsStr",
//               style: TextStyle(
//                 fontSize: 90.0,
//               ),
//             ),
//             SizedBox(height: 30.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 RaisedButton(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//                   onPressed: () {
//                     timerStream = stopWatchStream();
//                     timerSubscription = timerStream.listen((int newTick) {
//                       setState(() {
//                         hoursStr = ((newTick / (60 * 60)) % 60)
//                             .floor()
//                             .toString()
//                             .padLeft(2, '0');
//                         minutesStr = ((newTick / 60) % 60)
//                             .floor()
//                             .toString()
//                             .padLeft(2, '0');
//                         secondsStr =
//                             (newTick % 60).floor().toString().padLeft(2, '0');
//                       });
//                     });
//                   },
//                   color: Colors.green,
//                   child: Text(
//                     'START',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 40.0),
//                 RaisedButton(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//                   onPressed: () {
//                     timerSubscription.cancel();
//                     timerStream = null;
//                     setState(() {
//                       hoursStr = '00';
//                       minutesStr = '00';
//                       secondsStr = '00';
//                     });
//                   },
//                   color: Colors.red,
//                   child: Text(
//                     'RESET',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20.0,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
// import 'package:flutter/material.dart';


// import 'package:flutter/material.dart';
// import 'dart:async';

// StreamController<int> streamController = StreamController<int>();

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage('Flutter Demo Home Page', streamController.stream),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage(this.title, this.stream);
//   final String title;
//   final Stream<int> stream;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String menuName = 'A';

//   @override
//   void initState() {
//     super.initState();
//     widget.stream.listen((index) {
//       mySetState(index);
//     });
//   }

//   void mySetState(int index) {
//     List menuList = ['A', 'B', 'C'];
//     setState(() {
//       menuName = menuList[index];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(30.0),
//               child: Text(
//                 'Today\'s special is:',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Text(
//                 'Combo ' + menuName,
//                 style: TextStyle(fontSize: 30, color: Colors.blue),
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all<Color>(Colors.blue[700]),
//               ),
//               child: Text(
//                 'Settings',
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SecondPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SecondPage extends StatefulWidget {
//   @override
//   _SecondPageState createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage> {
//   List<bool> isSelected = [true, false, false];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Page'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(30.0),
//               child: Text(
//                 'Select a menu name:',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ToggleButtons(
//                 children: <Widget>[
//                   Text('A'),
//                   Text('B'),
//                   Text('C'),
//                 ],
//                 onPressed: (int index) {
//                   setState(() {
//                     for (int buttonIndex = 0;
//                         buttonIndex < isSelected.length;
//                         buttonIndex++) {
//                       if (buttonIndex == index) {
//                         isSelected[buttonIndex] = true;
//                       } else {
//                         isSelected[buttonIndex] = false;
//                       }
//                     }
//                   });
//                   streamController.add(index);
//                 },
//                 isSelected: isSelected,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// // Credit: https://github.com/bizz84/stopwatch-flutter 

// // import 'package:flutter/material.dart';
// // import 'dart:async';

// class ElapsedTime {
//   final int seconds;
//   final int minutes;
//   final int hours;

//   ElapsedTime({this.seconds, this.minutes, this.hours});
// }

// class Dependencies {
//   final List<ValueChanged<ElapsedTime>> timerListeners =
//       <ValueChanged<ElapsedTime>>[];
//   final Stopwatch stopwatch = new Stopwatch();
//   final int timerRefreshRate = 1;
// }

// class TimerButton extends StatefulWidget {
//   @override
//   _TimerButtonState createState() => _TimerButtonState();
// }

// class _TimerButtonState extends State<TimerButton> {
//   final Dependencies dependencies = new Dependencies();


//   void startStopButtonPressed() {
//     setState(() {
//       if (dependencies.stopwatch.isRunning) {
//         dependencies.stopwatch.stop();
//       } else {
//         dependencies.stopwatch.start();
//       }
//     });
//   }

//   Widget buildPlayStopButton(Icon icon, VoidCallback callback) {
//     return new IconButton(icon: icon, onPressed: callback);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         buildPlayStopButton(
//             dependencies.stopwatch.isRunning
//                 ? Icon(Icons.stop_rounded)
//                 : Icon(Icons.play_arrow_rounded),
//             startStopButtonPressed),
//         new TimerText(
//           dependencies: dependencies,
//         )
//       ],
//     );
//   }
// }

// class TimerText extends StatefulWidget {
//   TimerText({this.dependencies});

//   final Dependencies dependencies;

//   TimerTextState createState() =>
//       new TimerTextState(dependencies: dependencies);
// }

// class TimerTextState extends State<TimerText> {
//   TimerTextState({this.dependencies});

//   final Dependencies dependencies;
//   Timer timer;
//   int milliseconds;

//   @override
//   void initState() {
//     timer = new Timer.periodic(
//         new Duration(seconds: dependencies.timerRefreshRate), callback);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     timer = null;
//     super.dispose();
//   }

//   void callback(Timer timer) {
//     if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
//       milliseconds = dependencies.stopwatch.elapsedMilliseconds;
//       final int seconds = (milliseconds / 1000).truncate();
//       final int minutes = (seconds / 60).truncate();
//       final int hours = (minutes / 60).truncate();
//       final ElapsedTime elapsedTime = new ElapsedTime(
//         seconds: seconds,
//         minutes: minutes,
//         hours: hours,
//       );
//       for (final listener in dependencies.timerListeners) {
//         listener(elapsedTime);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: new MinutesSecondsHours(dependencies: dependencies),
//     );
//   }
// }

// class MinutesSecondsHours extends StatefulWidget {
//   MinutesSecondsHours({this.dependencies});

//   final Dependencies dependencies;

//   MinutesSecondsHoursState createState() =>
//       new MinutesSecondsHoursState(dependencies: dependencies);
// }

// class MinutesSecondsHoursState extends State<MinutesSecondsHours> {
//   MinutesSecondsHoursState({this.dependencies});

//   final Dependencies dependencies;

//   int hours = 0;
//   int minutes = 0;
//   int seconds = 0;

//   @override
//   void initState() {
//     dependencies.timerListeners.add(onTick);
//     super.initState();
//   }

//   void onTick(ElapsedTime elapsed) {
//     if (elapsed.hours != hours ||
//         elapsed.minutes != minutes ||
//         elapsed.seconds != seconds) {
//       setState(() {
//         hours = elapsed.hours;
//         minutes = elapsed.minutes;
//         seconds = elapsed.seconds;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String hourStr = (hours).toString().padLeft(2, '0');
//     String minutesStr = (minutes % 60).toString().padLeft(2, '0');
//     String secondsStr = (seconds % 60).toString().padLeft(2, '0');
//     return new Text('$hourStr:$minutesStr:$secondsStr');
//   }
// }

// // Credit: https://github.com/fayeed

// import 'dart:async';

// class TimerButton {
//   Stopwatch _watch;
//   Timer _timer;

//   StreamController<Duration> currentDuration = StreamController<Duration>();
//   Duration startTime;

//   TimerButton({this.startTime = Duration.zero}) {
//     _watch = Stopwatch();
//   }

//   void _onTick(Timer timer) {
//     final tempHour = startTime.inHours + _watch.elapsed.inHours;
//     final tempMinutes = startTime.inMinutes.remainder(60) +
//         _watch.elapsed.inMinutes.remainder(60);
//     final tempSeconds = startTime.inSeconds.remainder(60) +
//         _watch.elapsed.inSeconds.remainder(60);

//     final duration = Duration(
//       hours: tempHour,
//       minutes: tempMinutes,
//       seconds: tempSeconds,
//     );

//     currentDuration.add(duration);
//   }

//   void start() {
//     if (_timer != null) return;

//     _timer = Timer.periodic(Duration(seconds: 1), _onTick);
//     _watch.start();
//   }

//   void stop() {
//     _timer?.cancel();
//     _timer = null;
//     _watch.stop();
//     currentDuration.add(_watch.elapsed);
//   }

//   void reset() {
//     stop();
//     _watch.reset();
//     currentDuration.add(Duration.zero);
//   }
// }
