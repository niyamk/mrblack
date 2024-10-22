import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrblack/auths/storage_auth.dart';
import 'package:mrblack/screens/game_phase.dart';

class SelectGroupScreen extends StatefulWidget {
  const SelectGroupScreen({super.key});

  @override
  State<SelectGroupScreen> createState() => _SelectGroupScreenState();
}

class _SelectGroupScreenState extends State<SelectGroupScreen> {
  late Map<String, List<String>> groups;

  @override
  void initState() {
    super.initState();
    groups = Storage.group ?? {}; // Ensure this is properly initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: List.generate(
            groups.length,
            (index) {
              String currentGroupName = groups.keys.elementAt(index);
              List<String> playerNames = groups[currentGroupName]!;
              return Card(
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Text(
                              currentGroupName.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameScreen(
                                          players: playerNames,
                                        ),
                                      ));
                                },
                                child: Text("Play")),
                          ],
                        ),
                      ),
                      // Directly using GridView without Flexible or Expanded
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1, // Adjust aspect ratio as needed
                        ),
                        itemCount: playerNames.length,
                        // Use actual number of items
                        itemBuilder: (context, index2) {
                          return Card(
                            child: Center(
                              child: Text(playerNames[index2].toUpperCase()),
                            ),
                          );
                        },
                        physics: NeverScrollableScrollPhysics(),
                        // Disable scrolling for GridView
                        shrinkWrap:
                            true, // Allow GridView to take only necessary space
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
