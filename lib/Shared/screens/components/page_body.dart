import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/providers/page_state.dart';
import 'package:provider/provider.dart';

class PageBody extends StatelessWidget {
  const PageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageState state = Provider.of<PageState>(context);
    return state.widget;
  }
}