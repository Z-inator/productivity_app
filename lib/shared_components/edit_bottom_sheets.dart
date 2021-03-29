import 'package:flutter/material.dart';
import 'package:productivity_app/shared_components/status_related/status_edit_bottomsheet.dart';

showModalBottomSheet(
  context: context,
  isScrollControlled:
      true, // Allows the modal to me dynamic and keeps the menu above the keyboard
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25))),
  builder: (BuildContext context) {
    return StatusEditBottomSheet(
      status: status,
    );
  });