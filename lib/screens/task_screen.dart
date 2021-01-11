import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/time_page/time_log_list.dart';
import 'package:productivity_app/widgets/task_page/test.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListTile(
                    title: Text('Total Number of Tasks:'),
                    subtitle: Text('40'),
                  ),
                  TasksDueToday(),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: TimeLogList(),
          )
        ]);
  }
}

class TasksDueToday extends StatefulWidget {
  @override
  _TasksDueTodayState createState() => _TasksDueTodayState();
}

class _TasksDueTodayState extends State<TasksDueToday> {

  List<DueTask> dueTaskList = <DueTask> [
    DueTask(header: 'Due Task 1', bodyModel: BodyModel(price: 20, quantity: 10)),
    DueTask(header: 'Due Task 2', bodyModel: BodyModel(price: 20, quantity: 10)),
    DueTask(header: 'Due Task 3', bodyModel: BodyModel(price: 20, quantity: 10)),
    DueTask(header: 'Due Task 4', bodyModel: BodyModel(price: 20, quantity: 10)),
    DueTask(header: 'Due Task 5', bodyModel: BodyModel(price: 20, quantity: 10)),
  ];

  final List<String> statuses = ['ToDo', 'In Progress', 'Done'];


  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: Duration(seconds: 1),
      expansionCallback: (int item, bool expanded) {
        setState(() {
          dueTaskList[index].isExpanded = !dueTaskList[index].isExpanded
        });
      },
      children: [
        ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text('Tasks Due Today:'),
                subtitle: Text('5'),
              );
            },
            isExpanded: dueTaskList[index].isExpanded,
            body: Container(
              height: 200,
              child: ListView.builder(
                itemCount: dueTaskList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: PopupMenuButton(
                            icon: Icon(Icons.check_circle_outline_rounded),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  PopupMenuItem(child: Text(statuses[0])),
                                  PopupMenuItem(child: Text(statuses[1])),
                                  PopupMenuItem(child: Text(statuses[2])),
                                ]),
                      ),
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Task Name',
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .apply(fontSizeFactor: 1.3),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'Associated Project',
                                style: TextStyle(color: Colors.blue),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Text('Tracked Time'),
                      ),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: IconButton(
                            icon: Icon(Icons.today_rounded),
                            onPressed: () {},
                          ))
                    ],
                  );
                },
              ),
            ))
      ],
    );
  }
}
