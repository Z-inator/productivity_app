import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/screens/home_screen.dart';
import 'package:productivity_app/models/data.dart';

void main() => runApp(ProductivityApp());

class ProductivityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
