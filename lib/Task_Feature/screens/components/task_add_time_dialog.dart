// Future addTime() async {
//     // FocusNode _focusNode;
//     // TextEditingController _textEditingControllerHour;
//     // TextEditingController _textEditingControllerMinute =
//     //     TextEditingController();
//     // String hintText =
//     //     TimeFunctions().timeToTextHours(seconds: widget.task.taskTime);
//     // String text;

//     // void setText() {
//     //   setState(() {
//     //     text = _textEditingControllerMinute.text;
//     //   });
//     // }

//     // @override
//     // void initState() {
//     //   // _textEditingControllerHour = TextEditingController();
//     //   // _textEditingControllerMinute.addListener(setText());
//     //   minuteFocusNode = FocusNode();
//     //   hourFocusNode = FocusNode();
//     //   // _focusNode.addListener(() {
//     //   //   if (_focusNode.hasFocus) {
//     //   //     hintText = '';
//     //   //   } else {
//     //   //     hintText = TimeFunctions().timeToTextHours(seconds: widget.task.taskTime);
//     //   //   }
//     //   // });
//     //   super.initState();
//     // }

//     // @override
//     // void dispose() {
//     //   _textEditingControllerMinute.dispose();
//     //   super.dispose();
//     // }

//     return showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Enter Time',
//                 style:
//                     TextStyle(color: DynamicTheme.of(context).theme.unselectedWidgetColor)),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(25))),
//             content: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                   child: TextField(
//                     focusNode: hourFocusNode,
//                     textAlign: TextAlign.center,
//                     // controller: _textEditingControllerHour,
//                     style: TextStyle(
//                       fontSize: 50,
//                       color: DynamicTheme.of(context).theme.unselectedWidgetColor,
//                     ),
//                     decoration: InputDecoration(
//                         counterText: '',
//                         contentPadding: EdgeInsets.all(5),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: DynamicTheme.of(context).theme.accentColor)),
//                         border: OutlineInputBorder()),
//                     keyboardType: TextInputType.number,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                       LengthLimitingTextInputFormatter(4),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         _addedTime == null
//                             ? _addedTime = Duration(hours: int.parse(value))
//                             : _addedTime =
//                                 _addedTime + Duration(hours: int.parse(value));
//                       });
//                     },
//                     // onEditingComplete: () {
//                     //   _textEditingControllerHour.text = _addedTime == null
//                     //       ? TimeFunctions()
//                     //           .timeToTextHours(seconds: widget.task.taskTime)
//                     //       : TimeFunctions()
//                     //           .timeToTextHours(seconds: _addedTime.inSeconds);
//                     // },
//                   ),
//                 ),
//                 Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Text(
//                       ':',
//                       textAlign: TextAlign.center,
//                       style: DynamicTheme.of(context).theme.textTheme.headline3,
//                     )),
//                 Expanded(
//                   child: TextField(
//                     focusNode: hourFocusNode,
//                     textAlign: TextAlign.center,
//                     // controller: _textEditingControllerMinute,
//                     style: TextStyle(
//                       fontSize: 50,
//                       color: DynamicTheme.of(context).theme.unselectedWidgetColor,
//                     ),
//                     decoration: InputDecoration(
//                         counterText: '',
//                         contentPadding: EdgeInsets.all(5),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: DynamicTheme.of(context).theme.accentColor)),
//                         border: OutlineInputBorder()),
//                     keyboardType: TextInputType.number,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                       LengthLimitingTextInputFormatter(2),
//                     ],
//                     onChanged: (value) {
//                       setState(() {

//                       });
//                     },
//                     // onEditingComplete: () {
//                     //   if (text.length == 1) {
//                     //     text.padLeft(2, '0');
//                     //   } else if (text.length == 0) {
//                     //     text = '00';
//                     //   }
//                       // _textEditingControllerMinute.text = _addedTime == null
//                       //     ? TimeFunctions()
//                       //         .timeToTextMinutes(seconds: widget.task.taskTime)
//                       //     : TimeFunctions()
//                       //         .timeToTextMinutes(seconds: _addedTime.inSeconds);
//                     // },
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Container(
//                     child: IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.access_time_rounded,
//                           color: DynamicTheme.of(context).theme.unselectedWidgetColor,
//                         )),
//                   ),
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text('Cancel')),
//                         TextButton(
//                             onPressed: () {
//                               if (_addedTime.inSeconds != 0) {
//                                 newTask.taskTime = _addedTime.inSeconds;
//                               }
//                               Navigator.pop(context);
//                             },
//                             child: Text('Ok')),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           );
//         });
//   }
// }

// // class MinuteRangeTextInputFormatter extends TextInputFormatter {
// //   int maxValue = 59;

// //   @override
// //   TextEditingValue formatEditUpdate(
// //       TextEditingValue oldValue, TextEditingValue newValue) {
// //     if (newValue.text.length > 2) {
// //       return oldValue;
// //     } else if (newValue.text.length == 1) {
// //       return TextEditingValue(text: '0${newValue.text}');
// //     } else if (int.parse(newValue.text) > 59) {
// //       return TextEditingValue(text: 59.toString());
// //     }

// //     return newValue;
// //   }
// // }

// // class HourRangeTextInputFormatter extends TextInputFormatter {
// //   @override
// //   TextEditingValue formatEditUpdate(
// //       TextEditingValue oldValue, TextEditingValue newValue) {
// //     if (newValue.text.length == 1) {
// //       return TextEditingValue(text: '0${newValue.text}');
// //     }
// //     return newValue;
// //   }
// // }

// // class MinuteFieldNavigator extends TextInputFormatter {
// //   final FocusNode focusNodeNext;
// //   final BuildContext context;

// //   MinuteFieldNavigator({this.context, this.focusNodeNext});

// //   TextEditingValue formatEditUpdate(
// //       TextEditingValue oldValue, TextEditingValue newValue) {
// //     if (oldValue.text.length == 1 && newValue.text.length == 2) {
// //       FocusScope.of(context).requestFocus(focusNodeNext);
// //     }
// //     return newValue;
// //   }
// // }

// // class HourFieldNavigator extends TextInputFormatter {
// //   final FocusNode focusNodeNext;
// //   final BuildContext context;

// //   HourFieldNavigator({this.context, this.focusNodeNext});

// //   TextEditingValue formatEditUpdate(
// //       TextEditingValue oldValue, TextEditingValue newValue) {
// //     if (oldValue.text.length == 3 && newValue.text.length == 4) {
// //       FocusScope.of(context).requestFocus(focusNodeNext);
// //     }
// //     return newValue;
// //   }
// // }
