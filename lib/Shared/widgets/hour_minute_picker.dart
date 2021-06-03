import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ManualTimePicker extends StatefulWidget {
  final Function(int) saveManualTime;
  const ManualTimePicker({Key key, this.saveManualTime}) : super(key: key);

  @override
  _ManualTimePickerState createState() => _ManualTimePickerState();
}

class _ManualTimePickerState extends State<ManualTimePicker> {
  int hoursAdded;
  int minutesAdded;

  Future addManualTime(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Add Manual Time'),
              content: Row(
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
                            borderSide: BorderSide(
                                color: DynamicColorTheme.of(context)
                                    .data
                                    .accentColor)),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3)
                      ],
                      onChanged: (value) {
                        setState(() {
                          hoursAdded = int.parse(value);
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
                            borderSide: BorderSide(
                                color: DynamicColorTheme.of(context)
                                    .data
                                    .accentColor)),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                        MinuteRangeTextInputFormatter()
                      ],
                      onChanged: (value) {
                        setState(() {
                          minutesAdded = int.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      widget.saveManualTime(hoursAdded * 60 + minutesAdded);
                      Navigator.pop(context);
                    },
                    child: Text('Ok')),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(Icons.more_time_rounded),
      onPressed: () => addManualTime(context),
      label: Text('Add Manual Time'),
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
