import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';

class HomeDashBoard extends StatelessWidget {
   
  const HomeDashBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),),
                    title: Text('Butt Face'),
                    subtitle: Text(DateTimeFunctions().dateTimeToTextDate(date: DateTime.now())),
                    onTap: () => Scaffold.of(context).openDrawer()
                    ),
                  Text('The secret of your future is hidden in your daily routine',style: Theme.of(context).textTheme.subtitle1.copyWith(fontStyle: FontStyle.italic)),
                  Text('Mike Murdock', style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
            ),
            TimeChartPageView(),
            
          ],
        ),
      ),
    );
  }
}

class TimeChartPageView extends StatelessWidget {
  TimeChartPageView({Key key}) : super(key: key);

  PageController controller;

  @override
  Widget build(BuildContext context) {
    controller = PageController(initialPage: 0);
    return Container(
      child: PageView(
        controller: controller,
        children: [
          Card(child: TimeBarChart()),
          Card(child: TimePieChart()),
          Card(child: TimeBarChartByProject())
        ],
      ),
    );
  }
}

class TimeBarChart extends StatelessWidget {
  const TimeBarChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BarChart(
        BarChartData()
      ),
    );
  }
}

class TimePieChart extends StatelessWidget {
  const TimePieChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PieChart(
        PieChartData()
      ),
    );
  }
}

class TimeBarChartByProject extends StatelessWidget {
  const TimeBarChartByProject({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BarChart(
        BarChartData()
      ),
    );
  }
}