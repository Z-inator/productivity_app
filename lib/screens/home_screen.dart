import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/widgets/time_log_list_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
        child: ListView(
          shrinkWrap: true,
            children: <Widget>[
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                                  ),
                                title: Text('User\'s Name'),
                                subtitle: Text('12/25/2020'),   // TODO: add live date
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: ListTile(
                                leading: Icon(Icons.playlist_add_check_rounded),
                                title: Text('Tasks Due Today: 4'),
                                subtitle: Text('Total Tracked Time for the week: 20'),
                              ),
                            )
                          ]
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                                child: Table(
                                      children: [
                                        TableRow(
                                          children: <Widget> [
                                            TableCell(
                                              child: CircularPercentIndicator(
                                                radius: 50,
                                                lineWidth: 5,
                                                percent: .5,
                                                center: new Text('100%'),
                                                footer: Text('Habit'),
                                                progressColor: Colors.green,
                                                animation: true,
                                                animationDuration: 1200,
                                                circularStrokeCap: CircularStrokeCap.round,
                                              ),
                                            ),
                                            TableCell(
                                              child: CircularPercentIndicator(
                                                radius: 50,
                                                lineWidth: 5,
                                                percent: .5,
                                                center: new Text('100%'),
                                                footer: Text('Habit'),
                                                progressColor: Colors.green,
                                                animation: true,
                                                animationDuration: 1200,
                                                circularStrokeCap: CircularStrokeCap.round,
                                              ),
                                            ),
                                            TableCell(
                                              child: CircularPercentIndicator(
                                                radius: 50,
                                                lineWidth: 5,
                                                percent: .5,
                                                center: new Text('100%'),
                                                footer: Text('Habit'),
                                                progressColor: Colors.green,
                                                animation: true,
                                                animationDuration: 1200,
                                                circularStrokeCap: CircularStrokeCap.round,
                                              ),
                                            ),
                                          ]
                                        ),
                                        TableRow(
                                          children: <Widget> [
                                            TableCell(
                                              child: CircularPercentIndicator(
                                                radius: 50,
                                                lineWidth: 5,
                                                percent: .5,
                                                center: new Text('100%'),
                                                footer: Text('Habit'),
                                                progressColor: Colors.green,
                                                animation: true,
                                                animationDuration: 1200,
                                                circularStrokeCap: CircularStrokeCap.round,
                                              ),
                                            ),
                                            TableCell(
                                              child: CircularPercentIndicator(
                                                radius: 50,
                                                lineWidth: 5,
                                                percent: .5,
                                                center: new Text('100%'),
                                                footer: Text('Habit'),
                                                progressColor: Colors.green,
                                                animation: true,
                                                animationDuration: 1200,
                                                circularStrokeCap: CircularStrokeCap.round,
                                              ),
                                            ),
                                            TableCell(
                                              child: CircularPercentIndicator(
                                                radius: 50,
                                                lineWidth: 5,
                                                percent: .5,
                                                center: new Text('100%'),
                                                footer: Text('Habit'),
                                                progressColor: Colors.green,
                                                animation: true,
                                                animationDuration: 1200,
                                                circularStrokeCap: CircularStrokeCap.round,
                                              ),
                                            ),
                                          ]
                                        ),
                                      ]
                                    ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: FAProgressBar(
                                            maxValue: 100,
                                            currentValue: 20,
                                            progressColor: Colors.blue,
                                            changeColorValue: 75,
                                            changeProgressColor: Colors.green,
                                            displayText: '%',
                                            animatedDuration: Duration(milliseconds: 1200),
                                            direction: Axis.vertical,
                                            verticalDirection: VerticalDirection.up,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        Text('Goal')
                                      ]
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: FAProgressBar(
                                            maxValue: 100,
                                            currentValue: 60,
                                            progressColor: Colors.blue,
                                            changeColorValue: 75,
                                            changeProgressColor: Colors.green,
                                            displayText: '%',
                                            animatedDuration: Duration(milliseconds: 1200),
                                            direction: Axis.vertical,
                                            verticalDirection: VerticalDirection.up,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        Text('Goal')
                                      ]
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: FAProgressBar(
                                            maxValue: 100,
                                            currentValue: 80,
                                            progressColor: Colors.blue,
                                            changeColorValue: 75,
                                            changeProgressColor: Colors.green,
                                            displayText: '%',
                                            animatedDuration: Duration(milliseconds: 1200),
                                            direction: Axis.vertical,
                                            verticalDirection: VerticalDirection.up,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        Text('Goal')
                                      ]
                                    ),
                                  ],
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    ]
                  )
                )
              ),
                      
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TimeLogList()
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TimeLogList()
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TimeLogList()
              ),
            ]
          ),
        )
      ],
    );
  }
}
