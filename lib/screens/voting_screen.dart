import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mrblack/screens/game_phase.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen(
      {super.key, required this.playersAndTheirWords, this.unndercoverName});
  final unndercoverName;
  final List<List<String>> playersAndTheirWords;

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  List<List<String>> playerNameAndTheirWord = [];
  List<String> playersVotedOut = [];
  late String undercoverName;
  @override
  void initState() {
    playerNameAndTheirWord = widget.playersAndTheirWords;
    playerNameAndTheirWord.shuffle();
    undercoverName = widget.unndercoverName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.builder(
          itemCount: playerNameAndTheirWord.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            String playerName = playerNameAndTheirWord[index][0];
            return GestureDetector(
              onTap: () {
                if (!playersVotedOut.contains(playerName)) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Are you sure?"),
                        content: Row(
                          children: [
                            Text("Do you want to vote  "),
                            Text(
                              playerName.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                playersVotedOut
                                    .add(playerNameAndTheirWord[index][0]);
                                Navigator.pop(context);
                                checkWinningCondition();
                                setState(() {});
                              },
                              child: Text("Yes")),
                        ],
                      );
                    },
                  );
                }
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(1, 0),
                        child: CircleAvatar(
                          child: Text((index + 1).toString()),
                        ),
                      ),
                      Spacer(flex: 1),
                      Text(
                        '${playerNameAndTheirWord[index][0].toUpperCase()}\n${playerNameAndTheirWord[index][1]}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: playersVotedOut.contains(playerName)
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

//todo: stop game if winning condition matched
  void checkWinningCondition() {
    if (playersVotedOut.contains(undercoverName.toLowerCase())) {
      log("Game Over");
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Text("Game Over , Civilians won"),
          );
        },
      );
    }
  }
}
