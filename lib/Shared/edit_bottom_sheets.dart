// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:productivity_app/Task_Feature/screens/components/status_edit_bottomsheet.dart';

// class EditBottomSheet extends StatelessWidget {
//   const EditBottomSheet({Key key}) : super(key: key);

//   void showEditBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled:
//             true, // Allows the modal to me dynamic and keeps the menu above the keyboard
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(25), topRight: Radius.circular(25))),
//         builder: (BuildContext context) {
//           return StatusEditBottomSheet(
//             status: status,
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return showEditBottomSheet(context);
//   }
// }
