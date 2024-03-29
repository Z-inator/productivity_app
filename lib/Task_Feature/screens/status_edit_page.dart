import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Services/database.dart';

class StatusEditPage extends StatefulWidget {
  StatusEditPage({Key? key}) : super(key: key);

  @override
  _StatusEditPageState createState() => _StatusEditPageState();
}

class _StatusEditPageState extends State<StatusEditPage> {
  late List<Status> statuses;
  FirebaseFirestore instance = FirebaseFirestore.instance;
  WriteBatch? batch;

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    ThemeData themeData = DynamicColorTheme.of(context).data;
    DatabaseService databaseService = Provider.of<DatabaseService>(context);
    statuses = Provider.of<List<Status>>(context);
    // statuses.sort((a, b) => a.statusOrder!.compareTo(b.statusOrder!));
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            statuses.forEach((status) {
              status.statusOrder = statuses.indexOf(status) + 1;
            });
            databaseService.updateBatchItems('statuses', statuses);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Updated Statuses')));
            Navigator.pop(context);
          },
        ),
        title: Text('Edit Statuses'),
      ),
      body: Stack(children: [
        ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            setState(() {
              Status statusToRemove = statuses[oldIndex];
              statuses.removeAt(oldIndex);
              statuses.insert(newIndex, statusToRemove);
            });
          },
          header: ListTile(
            title: Text(
                'Statuses are used to track the completion state of a task.'),
            subtitle: Text('Long press on status to drag to reorder.'),
          ),
          children: statuses.map((status) {
            return ExpansionTile(
              key: Key(status.id!),
              leading: Icon(Icons.circle,
                  color: DynamicColorTheme.of(context).isDark
                      ? colorList[status.statusColor!].shade200
                      : colorList[status.statusColor!]),
              title: Text(
                status.statusName!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                      IconButton(
                        icon: Icon(Icons.delete_rounded),
                        tooltip: 'Delete Status',
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    'Delete Status: ${status.statusName}?'),
                                content: ListTile(
                                  title: Text(
                                      'This will permanently delete this status.\nIt will not effect related tasks.'),
                                ),
                                actions: [
                                  OutlinedButton.icon(
                                    icon: Icon(Icons.cancel_rounded),
                                    label: Text('Cancel'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  ElevatedButton.icon(
                                      icon: Icon(
                                          Icons.check_circle_outline_rounded),
                                      label: Text('Delete'),
                                      onPressed: () {
                                        databaseService.deleteItem(
                                            collectionReference: databaseService
                                                .statusReference!,
                                            objectID: status.id!);
                                        statuses.removeWhere((removeStatus) =>
                                            removeStatus.id == status.id);
                                        statuses.forEach((status) {
                                          status.statusOrder =
                                              statuses.indexOf(status) + 1;
                                        });
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            }),
                      ),
                      IconButton(
                          icon: Icon(Icons.edit_rounded),
                          tooltip: 'Edit Status',
                          onPressed: () => EditBottomSheet()
                              .buildEditBottomSheet(
                                  context: context,
                                  bottomSheet: StatusEditBottomSheet(
                                      isUpdate: true, status: status))),
                    ])),
                ListTile(
                  title: Text('Description:',
                      style: themeData
                          .textTheme
                          .subtitle1),
                  subtitle: Text(
                    status.statusDescription ?? 'No Description',
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                    style:
                        themeData.textTheme.bodyText1,
                  ),
                )
              ],
            );
          }).toList(),
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
                        status: Status(statusOrder: statuses.length + 1),
                      )),
                ),
                // ElevatedButton.icon(
                //   icon: Icon(Icons.check_circle_outline_rounded),
                //   label: Text('Update'),
                //   onPressed: () {
                //     statuses.forEach((status) {
                //       status.statusOrder = statuses.indexOf(status) + 1;
                //     });
                //     databaseService.updateBatchItems('statuses', statuses);
                //     ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text('Updated Statuses')));
                //   },
                // ),
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
