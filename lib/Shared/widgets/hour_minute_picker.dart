import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';


// class TimeRangePicker extends StatefulWidget {
//   TimeRangePicker({this.newTask});

//   final Task newTask;

//   @override
//   _TimeRangePickerState createState() => _TimeRangePickerState();
// }

// class _TimeRangePickerState extends State<TimeRangePicker> {
//   TimeOfDay _startingTime;
//   TimeOfDay _endingTime;

//   Future selectStartTime() async {
//     final TimeOfDay pickedTime =
//         await showTimePicker(context: context, initialTime: _startingTime);
//     if (pickedTime != null) {
//       setState(() {
//         _startingTime = pickedTime;
//       });
//     }
//   }

//   Future selectEndTime() async {
//     final TimeOfDay pickedTime =
//         await showTimePicker(context: context, initialTime: TimeOfDay.now());
//     if (pickedTime != null) {
//       setState(() {
//         _endingTime = pickedTime;
//       });
//     }
//   }

//   @override
//   void initState() {
//     _startingTime = TimeOfDay.now();
//     _endingTime = TimeOfDay.now().replacing(hour: _startingTime.hour + 1);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Text('Start Time: '),
//         OutlinedButton.icon(
//           onPressed: selectStartTime,
//           icon: Icon(Icons.schedule_rounded),
//           label: Text(_startingTime.format(context)),
//           style: OutlinedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(25)))),
//         ),
//         Text('End Time: '),
//         OutlinedButton.icon(
//           onPressed: selectEndTime,
//           icon: Icon(Icons.schedule_rounded),
//           label: Text(_startingTime.format(context)),
//           style: OutlinedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(25)))),
//         )
//       ],
//     );
//   }
// }

class HourMinutePicker extends StatefulWidget {
  HourMinutePicker({
    @required this.newTask,
  });

  final Task newTask;

  @override
  _HourMinutePickerState createState() => _HourMinutePickerState();
}

class _HourMinutePickerState extends State<HourMinutePicker> {
  Duration _addedTime = Duration(seconds: 0);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(5),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            onChanged: (value) {
              setState(() {
                _addedTime += Duration(hours: int.parse(value));
              });
            },
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              ':',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50),
            )),
        Expanded(
          child: TextField(
            // TODO: add forced 0 to left if only 1 digit
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(5),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
              MinuteRangeTextInputFormatter()
            ],
            onChanged: (value) {
              setState(() {
                _addedTime += Duration(minutes: int.parse(value));
              });
            },
          ),
        ),
      ],
    );
  }
}

class MinuteRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue == '') {
      return TextEditingValue();
    } else if (int.parse(newValue.text) < 1) {
      return TextEditingValue().copyWith(text: '1');
    }
    return int.parse(newValue.text) > 59
        ? TextEditingValue().copyWith(text: '59')
        : newValue;
  }
}
