import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:mrblack/screens/home_screen.dart';
import 'package:mrblack/screens/select_group_screen.dart';
import 'package:mrblack/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // body: SelectGroupScreen(),
        body: TestScreen(),
      ),
    );
  }
}
