import 'dart:developer';

import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen(
      {super.key, required this.playersAndTheirWords, this.unndercoverName});
  final unndercoverName;
  final List<List<String>> playersAndTheirWords;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<String> playersAlive = [];
  List<String> playersDead = [];

  @override
  void initState() {
    widget.playersAndTheirWords.forEach(
      (element) => playersAlive.add(element[0]),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: playersAlive.length + playersDead.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => Card(),
      ),
    );
  }
}
