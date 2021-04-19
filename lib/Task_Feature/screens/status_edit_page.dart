import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:provider/provider.dart';

class StatusEditPage extends StatefulWidget {
  StatusEditPage({Key key}) : super(key: key);

  @override
  _StatusEditPageState createState() => _StatusEditPageState();
}

class _StatusEditPageState extends State<StatusEditPage> {
  @override
  Widget build(BuildContext context) {
    List<Status> statuses = Provider.of<List<Status>>(context);
    StatusService statusService = Provider.of<StatusService>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Edit Statuses'),
      ),
      body: Stack(children: [
        ReorderableListView(
          header: ListTile(
            title: Text(
                'Statuses are used to track the completion state of a task.'),
            subtitle: Text('Long press on status to drag to reorder.'),
          ),
          children: statuses.map((status) {
            return StatusExpansionTile(
              status: status,
              key: Key(status.statusID),
            );
          }).toList(),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final Status statusTile = statuses.removeAt(oldIndex);
              statuses.insert(newIndex, statusTile);
            });
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.add_rounded),
                  label: Text('Add Status'),
                  onPressed: () => EditBottomSheet().buildEditBottomSheet(
                      context: context,
                      bottomSheet: StatusEditBottomSheet(
                        isUpdate: false,
                        statusOrder: statuses.length + 1,
                      )),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.check_circle_outline_rounded),
                  label: Text('Update'),
                  onPressed: () {
                    statuses.forEach((status) {
                      status.statusOrder = statuses.indexOf(status) + 1;
                      statusService.updateStatus(
                          statusID: status.statusID,
                          updateData: status.toFirestore());
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
