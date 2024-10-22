import 'dart:developer';

import 'package:flutter/material.dart';

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
  List<String> playerRemaining = [];
  late String undercoverName;
  Map<String, List<String>> dataMap = {};
  bool showWord = false;
  @override
  void initState() {
    playerNameAndTheirWord = widget.playersAndTheirWords;
    playerNameAndTheirWord.shuffle();
    undercoverName = widget.unndercoverName;
    playerNameAndTheirWord.forEach(
      (element) {
        String name = element[0];
        String message = element[1].toLowerCase();

        if (dataMap.containsKey(message)) {
          dataMap[message]!.add(name);
        } else {
          dataMap[message] = [name];
        }

        playerRemaining.add(element[0]);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(dataMap.toString());
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showWord = !showWord;
                });
              },
              child: CircleAvatar(
                radius: 25,
                child: Icon(showWord ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            GestureDetector(
              // onLongPress: () {},
              onTap: () {
                setState(() {
                  playerNameAndTheirWord.shuffle();
                });
              },
              child: Tooltip(
                message: 'hello' ?? "",
                triggerMode: TooltipTriggerMode.longPress,
                showDuration: const Duration(seconds: 30),
                child: CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.redo),
                ),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: GridView.builder(
          itemCount: playerNameAndTheirWord.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            String playerName = playerNameAndTheirWord[index][0];
            String playerWord = playerNameAndTheirWord[index][1];

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    bool isWordVisible = false;
                    if (!playersVotedOut.contains(playerName) && !showWord) {
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
                    } else {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return AlertDialog(
                            title: Text(playerName.toUpperCase()),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Your Word is \n'),
                                Text(
                                  playerWord,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: isWordVisible
                                        ? Colors.black
                                        : Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (isWordVisible) {
                                      Navigator.pop(context);
                                    } else {
                                      setState(() {
                                        isWordVisible = true;
                                      });
                                    }
                                  },
                                  child: Text(isWordVisible ? "done" : "show")),
                            ],
                          );
                        },
                      );
                    }
                  },
                );
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
                        playerNameAndTheirWord[index][0].toUpperCase(),
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

//todo: not a todo but a reminder that this code was removed because it was
// todo: too complicated to add shuffle code

/* return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showWord = !showWord;
                });
              },
              child: CircleAvatar(
                radius: 25,
                child: Icon(showWord ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            GestureDetector(
              // onLongPress: () {},
              onTap: () {
                setState(() {
                  playerNameAndTheirWord.shuffle();
                });
              },
              child: Tooltip(
                message: 'hello' ?? "",
                triggerMode: TooltipTriggerMode.longPress,
                showDuration: const Duration(seconds: 30),
                child: CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.redo),
                ),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: GridView.builder(
          itemCount: playerNameAndTheirWord.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            String playerName = playerNameAndTheirWord[index][0];
            String playerWord = playerNameAndTheirWord[index][1];

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    bool isWordVisible = false;
                    if (!playersVotedOut.contains(playerName) && !showWord) {
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
                    } else {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return AlertDialog(
                            title: Text(playerName.toUpperCase()),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Your Word is \n'),
                                Text(
                                  playerWord,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: isWordVisible
                                        ? Colors.black
                                        : Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (isWordVisible) {
                                      Navigator.pop(context);
                                    } else {
                                      setState(() {
                                        isWordVisible = true;
                                      });
                                    }
                                  },
                                  child: Text(isWordVisible ? "done" : "show")),
                            ],
                          );
                        },
                      );
                    }
                  },
                );
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
                        playerNameAndTheirWord[index][0].toUpperCase(),
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
    );*/
