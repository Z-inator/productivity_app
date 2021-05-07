import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/color_selector.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/providers/status_edit_state.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class StatusEditBottomSheet extends StatelessWidget {
  final Status status;
  final bool isUpdate;
  StatusEditBottomSheet({Key key, this.status, this.isUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (context) => StatusEditState(oldStatus: status),
      builder: (context, child) {
        final StatusEditState statusEditState = Provider.of<StatusEditState>(context);
        final StatusService statusService = Provider.of<StatusService>(context);
        return Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: statusEditState.newStatus.statusName.isEmpty
                    ? 'Enter Status Name'
                    : statusEditState.newStatus.statusName),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  statusEditState.updateStatusName(newText);
                },
              ),
              ColorSelector(
                  saveColor: statusEditState.updateStatusColor,
                  matchColor: statusEditState.newStatus.statusColor),
              CheckboxListTile(
                  value: statusEditState.newStatus.equalToComplete,
                  title: Text('This Status represents Task Complete:',
                      style: Theme.of(context).textTheme.subtitle1),
                  onChanged: (bool value) => statusEditState.updateStatusComplete(value)),
              TextField(
                decoration: InputDecoration(
                  hintText: statusEditState.newStatus.statusDescription.isEmpty
                    ? 'Enter Status Description'
                    : statusEditState.newStatus.statusDescription),
                textAlign: TextAlign.center,
                maxLength: 150,
                maxLines: 3,
                onChanged: (newText) {
                  statusEditState.updateStatusDescription(newText);
                },
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.check_circle_outline_rounded),
                    label: Text(isUpdate ? 'Update' : 'Add'),
                    onPressed: () {
                      isUpdate
                            ? statusService.updateStatus(
                                statusID: status.statusID,
                                updateData: statusEditState.newStatus.toFirestore())
                            : statusService.addStatus(
                                addData: statusEditState.newStatus.toFirestore());
                        Navigator.pop(context);
                      }
                  ))
            ],
          ),
        );
      },
    );
  }
}

// class StatusEditBottomSheet extends statusEditStatefulWidget {
//   final Status status;

//   StatusEditBottomSheet({this.status});

//   @override
//   _StatusEditBottomSheetState createState() => _StatusEditBottomSheetState();
// }

// class _StatusEditBottomSheetState extends statusEditState<StatusEditBottomSheet> {
//   String newStatusName;
//   Color newStatusColor;
//   int newStatusColorValue;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             decoration: InputDecoration(
//                 hintText: widget.status.statusName ?? 'Status Name'),
//             textAlign: TextAlign.center,
//             onChanged: (newText) {
//               newStatusName = newText;
//             },
//           ),
//           statusEditStatefulBuilder(
//               builder: (BuildContext context, statusEditStateSetter modalSetState) {
//             return SingleChildScrollView(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: ProjectColors().colorList.map((color) {
//                   return IconButton(
//                       icon: (newStatusColor ??
//                                   Color(widget.status.statusColor)) ==
//                               Color(color)
//                           ? Icon(
//                               Icons.check_circle_rounded,
//                               color: Color(color),
//                               size: 36,
//                             )
//                           : Icon(
//                               Icons.circle,
//                               color: Color(color),
//                               size: 36,
//                             ),
//                       onPressed: () {
//                         modalSetState(() {
//                           newStatusColor = Color(color);
//                         });
//                       });
//                 }).toList(),
//               ),
//             );
//           }),
//           Container(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: ElevatedButton.icon(
//                 icon: Icon(Icons.check_circle_outline_rounded),
//                 label: Text('Submit'),
//                 onPressed: () {
//                   StatusService().updateStatus(
//                       statusID: widget.status.statusID,
//                       updateData: {
//                         'statusName': newStatusName ?? widget.status.statusName,
//                         'statusColor': int.parse(
//                                 '0x${newStatusColor.value.toRadixString(16).toUpperCase().toString()}') ??
//                             int.parse(
//                                 '0x${widget.status.statusColor.toString()}')
//                       });
//                   Navigator.pop(context);
//                 },
//               ))
//         ],
//       ),
//     );
//   }
// }
