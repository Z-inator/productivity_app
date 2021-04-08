import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:productivity_app/Shared/providers/page_state.dart';
import 'package:productivity_app/Shared/widgets/add_new_selector.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/task_project_screen.dart';
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
      create: (context) => PageState(),
      builder: (context, child) {
        PageState state = Provider.of<PageState>(context);
        return Container(
            child: SafeArea(
          child: Scaffold(
            body: state.widget,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              color: Colors.white,
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
                  // Container(
                  //   height: 36,
                  //   width: 36,
                  //   child: buildSpeedDial(context),
                  // ),
                  
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: CircleBorder(), primary: Colors.red),
                    child: Icon(Icons.add_rounded),
                    onPressed: () {},
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

            // Stack(children: [
            //   state.widget,
            //   Positioned(
            //     bottom: 0,
            //     left: 0,
            //     right: 0,
            //     child: Container(
            //       margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.all(Radius.circular(25)),
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.black.withOpacity(0.5),
            //               spreadRadius: 2,
            //               blurRadius: 7,
            //               offset: Offset(0, 5),
            //             )
            //           ]),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.all(Radius.circular(25)),
            //         child: BottomAppBar(
            //           color: Colors.white,
            //           child: Row(
            //             mainAxisSize: MainAxisSize.max,
            //             mainAxisAlignment: MainAxisAlignment.spaceAround,
            //             children: [
            //               IconButton(
            //                   icon: Icon(Icons.dashboard_rounded),
            //                   color: state.page == 0
            //                       ? Colors.black
            //                       : Theme.of(context).unselectedWidgetColor,
            //                   onPressed: () {
            //                     state.changePage(0);
            //                   }),
            //               IconButton(
            //                   icon: Icon(Icons.timer_rounded),
            //                   color: state.page == 1
            //                       ? Colors.black
            //                       : Theme.of(context).unselectedWidgetColor,
            //                   onPressed: () {
            //                     state.changePage(1);
            //                   }),
            //               // Container(
            //               //   height: 36,
            //               //   width: 36,
            //               //   child: buildSpeedDial(context),
            //               // ),
                          
            //               // ElevatedButton(
            //               //   style: ElevatedButton.styleFrom(shape: CircleBorder(), primary: Colors.red),
            //               //   child: Icon(Icons.add_rounded),
            //               //   onPressed: () {},
            //               // ),
            //               IconButton(
            //                   icon: Icon(Icons.rule_rounded),
            //                   color: state.page == 2
            //                       ? Colors.black
            //                       : Theme.of(context).unselectedWidgetColor,
            //                   onPressed: () {
            //                     state.changePage(2);
            //                   }),
            //               IconButton(
            //                   icon: Icon(Icons.bar_chart_rounded),
            //                   color: state.page == 3
            //                       ? Colors.black
            //                       : Theme.of(context).unselectedWidgetColor,
            //                   onPressed: () {
            //                     state.changePage(3);
            //                   }),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   )
            // ]),
            floatingActionButton: SpeedDial(

            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
          ),
        ));
      },
    );
  }

  SpeedDial buildSpeedDial(BuildContext context) {
    return SpeedDial(
      icon: Icons.add_rounded,
      activeIcon: Icons.close_rounded,
      visible: true,
      closeManually: false,
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.white,
      overlayOpacity: .5,
      tooltip: 'Add Menu',
      // marginBottom: 17,
      // marginEnd: MediaQuery.of(context).size.width / 2 - 28,
      // buttonSize: 36,
      backgroundColor: Theme.of(context).accentColor,
      foregroundColor: Theme.of(context).primaryColor,
      elevation: 4,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.timer_rounded, color: Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).cardColor,
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // Allows the modal to me dynamic and keeps the menu above the keyboard
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            builder: (BuildContext context) {
              return ChangeNotifierProvider(
                  create: (context) => TaskEditState(isUpdate: false),
                  child: TaskEditBottomSheet(
                    // isUpdate: false,
                  ));
            }),
        ),
        SpeedDialChild(
          child: Icon(Icons.timelapse_rounded, color: Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).cardColor,
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // Allows the modal to me dynamic and keeps the menu above the keyboard
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            builder: (BuildContext context) {
              return ChangeNotifierProvider(
                  create: (context) => TaskEditState(isUpdate: false),
                  child: TaskEditBottomSheet(
                    // isUpdate: false,
                  ));
            }),
        ),
        SpeedDialChild(
          child: Icon(Icons.rule_rounded, color: Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).cardColor,
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // Allows the modal to me dynamic and keeps the menu above the keyboard
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            builder: (BuildContext context) {
              return ChangeNotifierProvider(
                  create: (context) => TaskEditState(isUpdate: false),
                  child: TaskEditBottomSheet(
                    // isUpdate: false,
                  ));
            }),
        ),
        SpeedDialChild(
          child: Icon(Icons.topic_rounded, color: Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).cardColor,
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // Allows the modal to me dynamic and keeps the menu above the keyboard
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            builder: (BuildContext context) {
              return ChangeNotifierProvider(
                  create: (context) => ProjectEditState(isUpdate: false),
                  child: ProjectEditBottomSheet(
                    // isUpdate: false,
                  ));
            }),
        ),
        SpeedDialChild(
          child: Icon(Icons.bar_chart_rounded, color: Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).cardColor,
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // Allows the modal to me dynamic and keeps the menu above the keyboard
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            builder: (BuildContext context) {
              return ChangeNotifierProvider(
                  create: (context) => TaskEditState(isUpdate: false),
                  child: TaskEditBottomSheet(
                    // isUpdate: false,
                  ));
            }),
        )
      ],
    );
  }

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
}
