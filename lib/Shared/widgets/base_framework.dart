// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:productivity_app/Shared/providers/page_state.dart';
import 'package:productivity_app/Shared/widgets/add_new_selector.dart';
import 'package:productivity_app/Shared/widgets/add_speed_dial.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Shared/widgets/flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:productivity_app/Shared/widgets/flutter_speed_dial/src/speed_dial.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/task_project_screen.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/test_screen.dart';
import 'package:productivity_app/Time_Feature/screens/time_screen.dart';

class BaseFramework extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (context) => PageState(page: 0, widget: HomeScreen()),
      builder: (context, child) {
        return Container(
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            child: SafeArea(
              child: Scaffold(
                body: Stack(children: [PageBody(), BottomNavigationBar()]),
              ),
            ));
      },
    );
  }
}

class PageBody extends StatelessWidget {
  const PageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageState state = Provider.of<PageState>(context);
    return state.widget;
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageState state = Provider.of<PageState>(context);
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
        child: Card(
            elevation: 12,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: Icon(Icons.dashboard_rounded),
                    color: state.page == 0
                        ? Colors.black
                        : Theme.of(context).unselectedWidgetColor,
                    onPressed: () {
                      state.changePage(0);
                    }),
                IconButton(
                    icon: Icon(Icons.timer_rounded),
                    color: state.page == 1
                        ? Colors.black
                        : Theme.of(context).unselectedWidgetColor,
                    onPressed: () {
                      state.changePage(1);
                    }),
                AddSpeedDial(
                  // options: {
                  //   Icons.timer_rounded: EditBottomSheet()
                  //       .buildTimeEntryEditBottomSheet(
                  //           context: context, isUpdate: false),
                  //   Icons.timelapse_rounded: EditBottomSheet()
                  //       .buildTimeEntryEditBottomSheet(
                  //           context: context, isUpdate: false),
                  //   Icons.rule_rounded: EditBottomSheet()
                  //       .buildTaskEditBottomSheet(
                  //           context: context, isUpdate: false),
                  //   Icons.topic_rounded: EditBottomSheet()
                  //       .buildProjectEditBottomSheet(
                  //           context: context, isUpdate: false)
                  // }
                ),
                IconButton(
                    icon: Icon(Icons.rule_rounded),
                    color: state.page == 2
                        ? Colors.black
                        : Theme.of(context).unselectedWidgetColor,
                    onPressed: () {
                      state.changePage(2);
                    }),
                IconButton(
                    icon: Icon(Icons.bar_chart_rounded),
                    color: state.page == 3
                        ? Colors.black
                        : Theme.of(context).unselectedWidgetColor,
                    onPressed: () {
                      state.changePage(3);
                    }),
              ],
            ),
          ),
        ),
      // ),
    );
  }

  // Widget buildSpeedDial() {

  // }
}

// body: state.widget,
// bottomNavigationBar: BottomAppBar(
//   shape: CircularNotchedRectangle(),
//   color: Colors.white,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       IconButton(
//           icon: Icon(Icons.dashboard_rounded),
//           color: state.page == 0
//               ? Colors.black
//               : Theme.of(context).unselectedWidgetColor,
//           onPressed: () {
//             state.changePage(0);
//           }),
//       IconButton(
//           icon: Icon(Icons.timer_rounded),
//           color: state.page == 1
//               ? Colors.black
//               : Theme.of(context).unselectedWidgetColor,
//           onPressed: () {
//             state.changePage(1);
//           }),
//       // Container(
//       //   height: 36,
//       //   width: 36,
//       //   child: buildSpeedDial(context),
//       // ),

//       ElevatedButton(
//         style: ElevatedButton.styleFrom(shape: CircleBorder(), primary: Colors.red),
//         onPressed: () {},
//         child: Icon(Icons.add_rounded),
//       ),
//       IconButton(
//           icon: Icon(Icons.rule_rounded),
//           color: state.page == 2
//               ? Colors.black
//               : Theme.of(context).unselectedWidgetColor,
//           onPressed: () {
//             state.changePage(2);
//           }),
//       IconButton(
//           icon: Icon(Icons.bar_chart_rounded),
//           color: state.page == 3
//               ? Colors.black
//               : Theme.of(context).unselectedWidgetColor,
//           onPressed: () {
//             state.changePage(3);
//           }),
//     ],
//   ),
// ),

// Widget _buildFab(BuildContext context) {
//   final icons = [
//     Icons.timer_rounded,
//     Icons.timelapse_rounded,
//     Icons.rule_rounded,
//     Icons.topic_rounded,
//     Icons.bar_chart_rounded
//   ];
//   PageState state = Provider.of<PageState>(context);
//   return AnchoredOverlay(
//       showOverlay: state.showOverlay,
//       overlayBuilder: (context, offset) {
//         return CenterAbout(
//           position: Offset(offset.dx, offset.dy - icons.length * 35.0),
//           child: FabWithIcons(
//             state: state,
//             icons: icons,
//             onIconTapped: (index) {
//               switch (index) {
//                 case 0:
//                   return showModalBottomSheet(
//                       context: context,
//                       isScrollControlled:
//                           true, // Allows the modal to me dynamic and keeps the menu above the keyboard
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25))),
//                       builder: (BuildContext context) {
//                         return ChangeNotifierProvider(
//                             create: (context) =>
//                                 TaskEditState(isUpdate: false),
//                             child: TaskEditBottomSheet(
//                                 // isUpdate: false,
//                                 ));
//                       });
//                 case 1:
//                   return showModalBottomSheet(
//                       context: context,
//                       isScrollControlled:
//                           true, // Allows the modal to me dynamic and keeps the menu above the keyboard
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25))),
//                       builder: (BuildContext context) {
//                         return ChangeNotifierProvider(
//                             create: (context) =>
//                                 TaskEditState(isUpdate: false),
//                             child: TaskEditBottomSheet(
//                                 // isUpdate: false,
//                                 ));
//                       });
//                 case 2:
//                   return showModalBottomSheet(
//                       context: context,
//                       isScrollControlled:
//                           true, // Allows the modal to me dynamic and keeps the menu above the keyboard
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25))),
//                       builder: (BuildContext context) {
//                         return ChangeNotifierProvider(
//                             create: (context) =>
//                                 TaskEditState(isUpdate: false),
//                             child: TaskEditBottomSheet(
//                                 // isUpdate: false,
//                                 ));
//                       });
//                 case 3:
//                   return showModalBottomSheet(
//                       context: context,
//                       isScrollControlled:
//                           true, // Allows the modal to me dynamic and keeps the menu above the keyboard
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25))),
//                       builder: (BuildContext context) {
//                         return ChangeNotifierProvider(
//                           create: (context) =>
//                               ProjectEditState(isUpdate: false),
//                           child: ProjectEditBottomSheet(
//                               // isUpdate: false,
//                               ),
//                         );
//                       });
//                 case 4:
//                   return showModalBottomSheet(
//                       context: context,
//                       isScrollControlled:
//                           true, // Allows the modal to me dynamic and keeps the menu above the keyboard
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25))),
//                       builder: (BuildContext context) {
//                         return ChangeNotifierProvider(
//                             create: (context) =>
//                                 TaskEditState(isUpdate: false),
//                             child: TaskEditBottomSheet(
//                                 // isUpdate: false,
//                                 ));
//                       });
//                 default:
//               }
//             },
//           ),
//         );
//       },
//       child: ElevatedButton(
//         onPressed: () {
//           if (state.controller.isDismissed) {
//             state.controller.forward();
//           } else {
//             state.controller.reverse();
//           }
//         },
//         style: ElevatedButton.styleFrom(shape: CircleBorder()),
//         child: Icon(Icons.add_rounded),
//       ));
// }
