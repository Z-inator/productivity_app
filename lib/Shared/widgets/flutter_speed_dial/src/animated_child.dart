// import 'package:flutter/material.dart';
// import 'speed_dial.dart';

// class AnimatedChild extends AnimatedWidget {
//   final int? index;
//   final Color? backgroundColor;
//   final Color? foregroundColor;
//   final double? elevation;
//   final double buttonSize;
//   final Widget? child;
//   @override
//   final Key? key;

//   final String? label;
//   final TextStyle? labelStyle;
//   final Color? labelBackgroundColor;
//   final Widget? labelWidget;

//   final bool visible;
//   final bool? dark;
//   final VoidCallback? onTap;
//   final VoidCallback? onLongPress;
//   final VoidCallback? toggleChildren;
//   final ShapeBorder? shape;
//   final String? heroTag;
//   final bool? useColumn;
//   final bool? switchLabelPosition;

//   final double? childMarginBottom;
//   final double? childMarginTop;

//   const AnimatedChild({
//     this.key,
//     required Animation<double> animation,
//     this.index,
//     this.backgroundColor,
//     this.foregroundColor,
//     this.elevation = 6.0,
//     this.buttonSize = 56.0,
//     this.child,
//     this.label,
//     this.labelStyle,
//     this.labelBackgroundColor,
//     this.labelWidget,
//     this.visible = false,
//     this.dark,
//     this.onTap,
//     this.switchLabelPosition,
//     this.useColumn,
//     this.onLongPress,
//     this.toggleChildren,
//     this.shape,
//     this.heroTag,
//     this.childMarginBottom,
//     this.childMarginTop,
//   }) : super(listenable: animation);

//   Widget buildLabel() {
//     if (label == null && labelWidget == null) return Container();

//     if (labelWidget != null) {
//       return GestureDetector(
//         onTap: _performAction,
//         onLongPress: _performLongAction,
//         child: labelWidget,
//       );
//     }

//     return GestureDetector(
//       onTap: _performAction,
//       onLongPress: _performLongAction,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
//         margin: EdgeInsetsDirectional.fromSTEB(
//             20.0, childMarginTop!, 15.0, childMarginBottom!),
//         decoration: BoxDecoration(
//           color: labelBackgroundColor ??
//               (dark! ? Colors.grey[800] : Colors.grey[50]),
//           borderRadius: BorderRadius.all(Radius.circular(6.0)),
//           boxShadow: [
//             BoxShadow(
//               color: dark!
//                   ? Colors.grey[900]!.withOpacity(0.7)
//                   : Colors.grey.withOpacity(0.7),
//               offset: Offset(0.8, 0.8),
//               blurRadius: 2.4,
//             )
//           ],
//         ),
//         child: Text(label!, style: labelStyle),
//       ),
//     );
//   }

//   void _performAction() {
//     if (onTap != null) onTap!();
//     toggleChildren!();
//   }

//   void _performLongAction() {
//     if (onLongPress != null) onLongPress!();
//     toggleChildren!();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Animation<double> animation = listenable as Animation<double>;

//     final Widget button = ScaleTransition(
//         scale: animation,
//         child: FloatingActionButton(
//           key: key,
//           heroTag: heroTag,
//           onPressed: _performAction,
//           backgroundColor:
//               backgroundColor ?? (dark! ? Colors.grey[800] : Colors.grey[50]),
//           foregroundColor:
//               foregroundColor ?? (dark! ? Colors.white : Colors.black),
//           elevation: elevation ?? 6.0,
//           shape: shape,
//           child: child,
//         ));

//     final List<Widget> children = [
//       if (label != null || labelWidget != null)
//         ScaleTransition(
//           scale: animation,
//           child: Container(
//             padding: (child == null) ? EdgeInsets.symmetric(vertical: 8) : null,
//             child: buildLabel(),
//           ),
//         ),
//       if (child != null)
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 5),
//           height: buttonSize,
//           width: buttonSize,
//           child: (onLongPress == null)
//               ? button
//               : GestureDetector(
//                   onLongPress: _performLongAction,
//                   child: button,
//                 ),
//         )
//     ];

//     return buildColumnOrRow(
//       useColumn!,
//       mainAxisSize: MainAxisSize.min,
//       children: switchLabelPosition! ? children.reversed.toList() : children,
//     );
//   }
// }