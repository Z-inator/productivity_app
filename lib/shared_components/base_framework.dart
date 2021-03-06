import 'dart:math';

import 'package:flutter/material.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/services/timer.dart';
import 'package:productivity_app/shared_components/bottom_navigation_bar.dart';
import 'package:productivity_app/shared_components/settings_drawer_widget.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/authentification_data.dart';

import 'bottom_navigation_bar2.dart';

class BaseFramework extends StatelessWidget {
  final Widget dashboard;
  final Widget content;

  final AuthService _auth = AuthService();
  String email = 'someone@gmail.com';
  String password = 'testing123456';

  BaseFramework({this.dashboard, this.content});

  // void initState() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.grey[50],
  //     statusBarBrightness: Brightness.light,
  //     statusBarIconBrightness: Brightness.dark,
  //   ));
  // }

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
          body: content,
        ),
        bottomNavigationBar: BottomNavigationBar2(),
        floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
              child: FloatingActionButton(
            onPressed: () async {
              // DatabaseService(uid: 'cNB6nEhkv0dJLhGJrvflz4P1jR33').addProject('test', 'color');
              AuthService().signInWithEmailAndPassword(email, password);

              // showDialog(
              // context: context,
              // builder: (BuildContext context) {
              //   return AlertDialog(
              //     title: Text('data'),
              //     content: TimerWidget(),
              //   );
              // });

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
