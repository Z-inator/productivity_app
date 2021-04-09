// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:productivity_app/Shared/providers/page_state.dart';
// import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
// import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
// import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
// import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
// import 'package:provider/provider.dart';
// import 'dart:math' as math;


// class FancyFab extends StatefulWidget {
//   final Function() onPressed;
//   final String tooltip;
//   final IconData icon;

//   const FancyFab({this.onPressed, this.tooltip, this.icon});

//   @override
//   _FancyFabState createState() => _FancyFabState();
// }

// class _FancyFabState extends State<FancyFab>
//     with SingleTickerProviderStateMixin {
//   bool isOpened = false;
//   AnimationController _animationController;
//   Animation<Color> _buttonColor;
//   Animation<double> _animateIcon;
//   Animation<double> _translateButton;
//   final Curve _curve = Curves.easeOut;
//   final double _fabHeight = 48;

//   @override
//   initState() {
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500))
//           ..addListener(() {
//             setState(() {});
//           });
//     _animateIcon =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
//     _buttonColor = ColorTween(
//       begin: Colors.blue,
//       end: Colors.red,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Interval(
//         0.00,
//         1.00,
//       ),
//     ));
//     _translateButton = Tween<double>(
//       begin: _fabHeight,
//       end: -14.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Interval(
//         0.0,
//         0.75,
//         curve: _curve,
//       ),
//     ));
//     super.initState();
//   }

//   @override
//   dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   animate() {
//     if (!isOpened) {
//       _animationController.forward();
//     } else {
//       _animationController.reverse();
//     }
//     isOpened = !isOpened;
//   }

//   Widget timer() {
//     return Container(
//       child: FloatingActionButton(
//         mini: true,
//         tooltip: 'Start Timer',
//         backgroundColor: Theme.of(context).cardColor,
//         onPressed: null,
//         child: Icon(Icons.timer_rounded, color: Theme.of(context).accentColor,),
//       ),
//     );
//   }

//   Widget timeEntry() {
//     return Container(
//       child: FloatingActionButton(
//         mini: true,
//         tooltip: 'Add Time Entry',
//         backgroundColor: Theme.of(context).cardColor,
//         onPressed: null,
//         child: Icon(Icons.timelapse_rounded, color: Theme.of(context).accentColor,),
//       ),
//     );
//   }

//   Widget task() {
//     return Container(
//       child: FloatingActionButton(
//         mini: true,
//         tooltip: 'Add Task',
//         backgroundColor: Theme.of(context).cardColor,
//         onPressed: null,
//         child: Icon(Icons.rule_rounded, color: Theme.of(context).accentColor,),
//       ),
//     );
//   }

//   Widget project() {
//     return Container(
//       child: FloatingActionButton(
//         mini: true,
//         tooltip: 'Add Project',
//         backgroundColor: Theme.of(context).cardColor,
//         onPressed: null,
//         child: Icon(Icons.topic_rounded, color: Theme.of(context).accentColor,),
//       ),
//     );
//   }

//   Widget goal() {
//     return Container(
//       child: FloatingActionButton(
//         mini: true,
//         tooltip: 'Add Goal',
//         backgroundColor: Theme.of(context).cardColor,
//         onPressed: null,
//         child: Icon(Icons.bar_chart_rounded, color: Theme.of(context).accentColor,),
//       ),
//     );
//   }

//   Widget toggle() {
//     return Container(
//       child: RotationTransition(
//         turns: CurvedAnimation(parent: _animationController, curve: Interval(0, .875, curve: _curve)),
//         child: FloatingActionButton(
//           mini: true,
//           backgroundColor: _buttonColor.value,
//           tooltip: 'Toggle',
//           onPressed: animate,
//           child: Icon(Icons.add_rounded),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value * 5,
//             0.0,
//           ),
//           child: timer(),
//         ),
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value * 4,
//             0.0,
//           ),
//           child: timeEntry(),
//         ),
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value * 3,
//             0.0,
//           ),
//           child: task(),
//         ),
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value * 2,
//             0.0,
//           ),
//           child: project(),
//         ),
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value,
//             0.0,
//           ),
//           child: goal(),
//         ),
//         toggle(),
//       ],
//     );
//   }
// }

// // class AddNew extends StatefulWidget {
// //   AddNew({Key key}) : super(key: key);

// //   @override
// //   _AddNewState createState() => _AddNewState();
// // }

// // class _AddNewState extends State<AddNew> with SingleTickerProviderStateMixin {
// //   AnimationController _controller;
// //   bool openMenu = false;

// //   onIconTapped(int index) {
// //     switch (index) {
// //       case 0:
// //         return;
// //       case 1:
// //         return;
// //       case 2:
// //         return showModalBottomSheet(
// //             context: context,
// //             isScrollControlled:
// //                 true, // Allows the modal to me dynamic and keeps the menu above the keyboard
// //             shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.only(
// //                     topLeft: Radius.circular(25),
// //                     topRight: Radius.circular(25))),
// //             builder: (BuildContext context) {
// //               return ChangeNotifierProvider(
// //                   create: (context) => TaskEditState(),
// //                   child: TaskEditBottomSheet(
// //                     isUpdate: false,
// //                   ));
// //             });
// //       case 3:
// //         return showModalBottomSheet(
// //             context: context,
// //             isScrollControlled:
// //                 true, // Allows the modal to me dynamic and keeps the menu above the keyboard
// //             shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.only(
// //                     topLeft: Radius.circular(25),
// //                     topRight: Radius.circular(25))),
// //             builder: (BuildContext context) {
// //               return ChangeNotifierProvider(
// //                 create: (context) => ProjectEditState(),
// //                 child: ProjectEditBottomSheet(
// //                   isUpdate: false,
// //                 ),
// //               );
// //             });
// //       default:
// //     }
// //   }

// //   @override
// //   void initState() {
// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 500),
// //     );
// //   }

// //   Widget build(BuildContext context) {
// //     Color backgroundColor = Theme.of(context).cardColor;
// //     Color foregroundColor = Theme.of(context).accentColor;
// //     return Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: List.generate(icons.length, (int index) {
// //           Widget child = Container(
// //             height: 70.0,
// //             width: 56.0,
// //             alignment: FractionalOffset.topCenter,
// //             child: ScaleTransition(
// //               scale: CurvedAnimation(
// //                 parent: _controller,
// //                 curve: Interval(
// //                   0.0,
// //                   1.0 - index / icons.length / 2.0,
// //                   curve: Curves.easeOut
// //                 ),
// //               ),
// //               child: FloatingActionButton(
// //                 heroTag: null,
// //                 backgroundColor: backgroundColor,
// //                 mini: true,
// //                 child: Icon(icons[index], color: foregroundColor),
// //                 onPressed: () {},
// //               ),
// //             ),
// //           );
// //           return child;
// //         }).toList()..add(
// //           FloatingActionButton(
// //             heroTag: null,
// //             child: AnimatedBuilder(
// //               animation: _controller,
// //               builder: (BuildContext context, Widget child) {
// //                 return Transform(
// //                   transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
// //                   alignment: FractionalOffset.center,
// //                   child: Icon(_controller.isDismissed ? Icons.add_rounded : Icons.close_rounded),
// //                 );
// //               },
// //             ),
// //             onPressed: () {
// //               if (_controller.isDismissed) {
// //                 _controller.forward();
// //               } else {
// //                 _controller.reverse();
// //               }
// //             },
// //           )
// //       ),
// //     );
// //   }
// // }

// // https://stackoverflow.com/questions/46480221/flutter-floating-action-button-with-speed-dail
// class FabWithIcons extends StatefulWidget {
//   FabWithIcons({this.icons, this.onIconTapped, this.state});
//   final List<IconData> icons;
//   final PageState state;
//   ValueChanged<int> onIconTapped;
//   @override
//   State createState() => FabWithIconsState();
// }

// class FabWithIconsState extends State<FabWithIcons>
//     with TickerProviderStateMixin {
//   // AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     widget.state.controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 250),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: List.generate(widget.icons.length, (int index) {
//           return _buildChild(index);
//         }).toList()
//         // ..add(
//         //   _buildFab(),
//         // ),
//         );
//   }

//   Widget _buildChild(int index) {
//     final Color backgroundColor = Theme.of(context).cardColor;
//     final Color foregroundColor = Theme.of(context).accentColor;
//     return Container(
//       height: 70.0,
//       width: 56.0,
//       alignment: FractionalOffset.topCenter,
//       child: ScaleTransition(
//         scale: CurvedAnimation(
//           parent: widget.state.controller,
//           curve: Interval(0.0, 1.0 - index / widget.icons.length / 2.0,
//               curve: Curves.easeOut),
//         ),
//         child: FloatingActionButton(
//           backgroundColor: backgroundColor,
//           mini: true,
//           onPressed: () => _onTapped(index),
//           child: Icon(widget.icons[index], color: foregroundColor),
//         ),
//       ),
//     );
//   }

//   // Widget _buildFab() {
//   //   return ElevatedButton(
//   //     onPressed: () {
//   //       if (_controller.isDismissed) {
//   //         _controller.forward();
//   //       } else {
//   //         _controller.reverse();
//   //       }
//   //     },
//   //     style: ElevatedButton.styleFrom(shape: CircleBorder()),
//   //     child: Icon(Icons.add_rounded),
//   //   );
//   // }

//   void _onTapped(int index) {
//     widget.state.controller.reverse();
//     widget.onIconTapped(index);
//   }
// }

// // code from: https://github.com/matthew-carroll/flutter_ui_challenge_feature_discovery
// // TODO: Use https://github.com/matthew-carroll/fluttery/blob/master/lib/src/layout_overlays.dart

// class AnchoredOverlay extends StatelessWidget {
//   final bool showOverlay;
//   final Widget Function(BuildContext, Offset anchor) overlayBuilder;
//   final Widget child;

//   const AnchoredOverlay({
//     this.showOverlay,
//     this.overlayBuilder,
//     this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//         return OverlayBuilder(
//           showOverlay: showOverlay,
//           overlayBuilder: (BuildContext overlayContext) {
//             final RenderBox box = context.findRenderObject() as RenderBox;
//             final center =
//                 box.size.center(box.localToGlobal(const Offset(0.0, 0.0)));
//             return overlayBuilder(overlayContext, center);
//           },
//           child: child,
//         );
//       }),
//     );
//   }
// }

// class OverlayBuilder extends StatefulWidget {
//   final bool showOverlay;
//   final Function(BuildContext) overlayBuilder;
//   final Widget child;

//   const OverlayBuilder({
//     this.showOverlay = false,
//     this.overlayBuilder,
//     this.child,
//   });

//   @override
//   _OverlayBuilderState createState() => _OverlayBuilderState();
// }

// class _OverlayBuilderState extends State<OverlayBuilder> {
//   OverlayEntry overlayEntry;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.showOverlay) {
//       WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());
//     }
//   }

//   @override
//   void didUpdateWidget(OverlayBuilder oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     WidgetsBinding.instance.addPostFrameCallback((_) => syncWidgetAndOverlay());
//   }

//   @override
//   void reassemble() {
//     super.reassemble();
//     WidgetsBinding.instance.addPostFrameCallback((_) => syncWidgetAndOverlay());
//   }

//   @override
//   void dispose() {
//     if (isShowingOverlay()) {
//       hideOverlay();
//     }

//     super.dispose();
//   }

//   bool isShowingOverlay() => overlayEntry != null;

//   void showOverlay() {
//     overlayEntry = OverlayEntry(
//       builder: widget.overlayBuilder,
//     );
//     addToOverlay(overlayEntry);
//   }

//   void addToOverlay(OverlayEntry entry) async {
//     print('addToOverlay');
//     Overlay.of(context).insert(entry);
//   }

//   void hideOverlay() {
//     print('hideOverlay');
//     overlayEntry.remove();
//     overlayEntry = null;
//   }

//   void syncWidgetAndOverlay() {
//     if (isShowingOverlay() && !widget.showOverlay) {
//       hideOverlay();
//     } else if (!isShowingOverlay() && widget.showOverlay) {
//       showOverlay();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }

// class CenterAbout extends StatelessWidget {
//   final Offset position;
//   final Widget child;

//   const CenterAbout({
//     this.position,
//     this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: position.dy,
//       left: position.dx,
//       child: FractionalTranslation(
//         translation: const Offset(-0.5, -0.5),
//         child: child,
//       ),
//     );
//   }
// }
