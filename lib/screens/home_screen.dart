import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrblack/auths/storage_auth.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late Map<String, List<String>> groups;

  @override
  void initState() {
    super.initState();
    groups = Storage.group; // Ensure this is properly initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Jod Gang",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 400, // Fixed height for GridView
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1, // Adjust aspect ratio as needed
                    ),
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Center(
                          child: Text(groups.keys.elementAt(index)),
                        ),
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    // Disable scrolling for GridView
                    shrinkWrap:
                        true, // Allow GridView to take only necessary space
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
