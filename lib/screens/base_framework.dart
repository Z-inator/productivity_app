import 'package:flutter/material.dart';
import 'package:productivity_app/models/timer.dart';
import 'package:productivity_app/models/timer.dart';
import 'package:productivity_app/components/home_page/home_page_dashboard.dart';
import 'package:productivity_app/components/home_page/task_tile_list_builder.dart';
import 'package:productivity_app/components/task_page/task_list.dart';
import 'home_screen.dart';
import 'time_screen.dart';
import 'task_screen.dart';
import 'package:productivity_app/components/bottom_navigation_bar.dart';
import 'package:productivity_app/components/settings_drawer_widget.dart';

class BaseFramework extends StatelessWidget {
  final Widget dashboard;
  final Widget list;

  BaseFramework({this.dashboard, this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: SafeArea(
          child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading:
                    false, // Hides the setting drawer icon
                floating: true,
                snap: true,
                stretch: true,
                expandedHeight: 300.0,
                backgroundColor: Colors.grey[50],
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: <StretchMode>[StretchMode.blurBackground],
                  background: Container(
                      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: dashboard),
                ),
                forceElevated: innerBoxIsScrolled,
                onStretchTrigger: () {
                  return;
                },
              )
            ];
          },
          body: list,
        ),
        bottomNavigationBar: BottomNavigationBarBase(),
        floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
              child: FloatingActionButton(
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Timer'),
                      content: TimerWidget(),
                      actions: <Widget>[
                        TextButton(
                          child: Text('close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });

              // Scaffold.of(context).showBottomSheet<void>(
              //   (BuildContext context) {
              //       return Container(
              //         height: 200,
              //         child: Center(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             mainAxisSize: MainAxisSize.min,
              //             children: <Widget>[
              //               new TimerButton(),
              //               IconButton(
              //                 icon: Icon(Icons.exit_to_app_rounded),
              //                 onPressed: () => Navigator.pop(context),
              //               )
              //             ],
              //           ),
              //         ),
              //       );
              //     }
              //     );
            },
            child: Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
          )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        drawer: SettingsDrawer(),
        // bottomSheet: Container(
        //               height: 200,
        //               child: Center(
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: <Widget>[
        //                     new TimerButton(),
        //                     IconButton(
        //                       icon: Icon(Icons.exit_to_app_rounded),
        //                       onPressed: () => Navigator.pop(context),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             )
      )),
    );
  }
}

// class BaseFramework extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search_rounded),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: TaskScreen()
//       ),
//       bottomNavigationBar: BottomNavigationBarBase(),
//       floatingActionButton: Container(
//         height: 65.0,
//         width: 65.0,
//         child: FittedBox(
//             child: FloatingActionButton(
//           onPressed: () {},
//           child: Icon(
//             Icons.add_rounded,
//             color: Colors.white,
//           ),
//         )),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       drawer: SettingsDrawer(),
//     );
//   }
// }
