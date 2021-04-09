import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      elevation: 10,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                        ),
                        title: Text('User\'s Name'),
                        subtitle: Text('12/25/2020'), // TODO: add live date
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: Text('Tasks Due Today: 4'),
                      subtitle: Text('Total Tracked Time for the week: 20'),
                    ),
                  )
                ]),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: Table(children: [
                    TableRow(children: <Widget>[
                      TableCell(
                        child: CircularPercentIndicator(
                          radius: 50,
                          percent: .5,
                          center: Text('100%'),
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
                          percent: .5,
                          center: Text('100%'),
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
                          percent: .5,
                          center: Text('100%'),
                          footer: Text('Habit'),
                          progressColor: Colors.green,
                          animation: true,
                          animationDuration: 1200,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      TableCell(
                        child: CircularPercentIndicator(
                          radius: 50,
                          percent: .5,
                          center: Text('100%'),
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
                          percent: .5,
                          center: Text('100%'),
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
                          percent: .5,
                          center: Text('100%'),
                          footer: Text('Habit'),
                          progressColor: Colors.green,
                          animation: true,
                          animationDuration: 1200,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ),
                    ]),
                  ]),
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Flexible(
                                  child: FAProgressBar(
                                    currentValue: 20,
                                    progressColor: Colors.blue,
                                    changeColorValue: 75,
                                    changeProgressColor: Colors.green,
                                    displayText: '%',
                                    animatedDuration:
                                        Duration(milliseconds: 1200),
                                    direction: Axis.vertical,
                                    verticalDirection: VerticalDirection.up,
                                    backgroundColor: Color(0xFFEFEF),
                                  ),
                                ),
                                Text('Goal')
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Flexible(
                                  child: FAProgressBar(
                                    currentValue: 60,
                                    progressColor: Colors.blue,
                                    changeColorValue: 75,
                                    changeProgressColor: Colors.green,
                                    displayText: '%',
                                    animatedDuration:
                                        Duration(milliseconds: 1200),
                                    direction: Axis.vertical,
                                    verticalDirection: VerticalDirection.up,
                                    backgroundColor: Color(0xFFEFEF),
                                  ),
                                ),
                                Text('Goal')
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Flexible(
                                  child: FAProgressBar(
                                    currentValue: 80,
                                    progressColor: Colors.blue,
                                    changeColorValue: 75,
                                    changeProgressColor: Colors.green,
                                    displayText: '%',
                                    animatedDuration:
                                        Duration(milliseconds: 1200),
                                    direction: Axis.vertical,
                                    verticalDirection: VerticalDirection.up,
                                    backgroundColor: Color(0xFFEFEF),
                                  ),
                                ),
                                Text('Goal')
                              ]),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ]);
  }
}
