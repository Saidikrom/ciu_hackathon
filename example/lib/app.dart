import 'package:flutter/material.dart';
import '3d.dart';
import 'login.dart';
import 'color.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //where to go
      home: Object3DScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
