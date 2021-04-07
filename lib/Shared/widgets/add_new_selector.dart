import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:provider/provider.dart';

class AddNew extends StatefulWidget {
  AddNew({Key key}) : super(key: key);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> with SingleTickerProviderStateMixin {
  AnimationController controller;
  bool openMenu = false;

  List<IconData> icons = [
    Icons.timer_rounded,
    Icons.timelapse_rounded,
    Icons.rule_rounded,
    Icons.topic_rounded,
    Icons.bar_chart_rounded
  ];

  onIconTapped(int index) {
    switch (index) {
      case 0:
        return;
      case 1:
        return;
      case 2:
        return showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // Allows the modal to me dynamic and keeps the menu above the keyboard
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            builder: (BuildContext context) {
              return ChangeNotifierProvider(
                  create: (context) => TaskEditState(),
                  child: TaskEditBottomSheet(
                    isUpdate: false,
                  ));
            });
      case 3:
        return showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // Allows the modal to me dynamic and keeps the menu above the keyboard
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            builder: (BuildContext context) {
              return ChangeNotifierProvider(
                create: (context) => ProjectEditState(),
                child: ProjectEditBottomSheet(
                  isUpdate: false,
                ),
              );
            });
      default:
    }
  }

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return new Scaffold(
      appBar: new AppBar(title: new Text('Speed Dial Example')),
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(
                  0.0,
                  1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut
                ),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                child: new Icon(icons[index], color: foregroundColor),
                onPressed: () {},
              ),
            ),
          );
          return child;
        }).toList()..add(
          new FloatingActionButton(
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(_controller.isDismissed ? Icons.share : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
      ),
    );
  }
}

