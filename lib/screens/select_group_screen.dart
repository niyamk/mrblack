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
    groups = Storage.group;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: groups.length,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          itemBuilder: (context, index) {
            String currentGroupName = groups.keys.toList()[index];
            List<String> playerNames = groups[currentGroupName]!;
            // Define the number of columns in the grid
            int crossAxisCount = 4;
            // Calculate the number of rows needed
            int rowCount = (playerNames.length / crossAxisCount).ceil();
            // Calculate the height of the GridView dynamically (assuming each item has a height of 100)
            double gridHeight = rowCount * 120; // Adjust per item height

            return Card(
              color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Spacer(flex: 5),
                      Text(currentGroupName.capitalize!),
                      Spacer(flex: 4),
                      GestureDetector(
                        child: Icon(Icons.play_arrow),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameScreen(
                                  players: playerNames,
                                ),
                              ));
                        },
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(
                    height: gridHeight, // Use dynamic height
                    child: GridView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling in GridView
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount, // Adjust as needed
                      ),
                      itemCount: playerNames.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(4),
                          // padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          alignment: Alignment.center,
                          child: Text(playerNames[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
