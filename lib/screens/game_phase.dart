// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:mrblack/auths/storage_auth.dart';
//
// class GameScreen extends StatefulWidget {
//   const GameScreen({super.key, required this.players});
//   final List<String> players;
//
//   @override
//   State<GameScreen> createState() => _GameScreenState();
// }
//
// class _GameScreenState extends State<GameScreen> {
//   late List<String> players;
//   late List<String> pairOfWord;
//   late int undercoverIndex;
//   late List<bool> revealedCards; // Track revealed cards
//
//   @override
//   void initState() {
//     super.initState();
//     players = widget.players;
//     players.shuffle();
//     pairOfWord =
//         Storage.words.elementAt(Random().nextInt(Storage.words.length));
//     undercoverIndex = Random().nextInt(players.length);
//     revealedCards =
//         List<bool>.filled(players.length, false); // Initialize the list
//   }
//
//   void _revealCard(int index) {
//     if (revealedCards[index]) {
//       return; // Do nothing if already revealed
//     }
//     // Show dialog with the card name
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Card Revealed'),
//           content: Text(players[index] == players[undercoverIndex]
//               ? pairOfWord[0]
//               : pairOfWord[1]),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   revealedCards[index] = true; // Change the state to revealed
//                 });
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(players.toString() +
//         "\n" +
//         pairOfWord.toString() +
//         '\n' +
//         players[undercoverIndex]);
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: revealedCards.length == players.length
//             ? Colors.purpleAccent
//             : Colors.grey,
//         child: Icon(Icons.keyboard_double_arrow_right),
//         onPressed: () {
//           if (revealedCards.length == players.length) {
//             print("u can move to next round");
//           }
//         },
//       ),
//       body: GridView.builder(
//         itemCount: players.length,
//         gridDelegate:
//             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () => _revealCard(index), // Call reveal function on tap
//             child: Card(
//               color: revealedCards[index]
//                   ? Colors.red
//                   : Colors.green, // Change color based on revealed state
//               child: Center(child: Text(players[index])),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mrblack/auths/storage_auth.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.players});
  final List<String> players;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<String> players;
  late List<String> pairOfWord;
  late int undercoverIndex;
  late List<bool> revealedCards; // Track revealed cards

  @override
  void initState() {
    super.initState();
    players = widget.players;
    players.shuffle();
    pairOfWord =
        Storage.words.elementAt(Random().nextInt(Storage.words.length));
    undercoverIndex = Random().nextInt(players.length);
    revealedCards =
        List<bool>.filled(players.length, false); // Initialize the list
  }

  void _revealCard(int index) {
    if (revealedCards[index]) {
      return; // Do nothing if already revealed
    }
    // Show dialog with the card name
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Card Revealed'),
          content: Text(players[index] == players[undercoverIndex]
              ? pairOfWord[0]
              : pairOfWord[1]),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  revealedCards[index] = true; // Change the state to revealed
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(players.toString() +
        "\n" +
        pairOfWord.toString() +
        '\n' +
        players[undercoverIndex]);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: revealedCards.contains(false)
            ? Colors.grey
            : FloatingActionButtonThemeData().backgroundColor,
        child: Icon(Icons.keyboard_double_arrow_right),
        onPressed: () {
          if (revealedCards.length == players.length) {
            print("u can move to next round");
          }
        },
      ),
      body: GridView.builder(
        itemCount: players.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _revealCard(index), // Call reveal function on tap
            child: Card(
              color: revealedCards[index]
                  ? Colors.red
                  : Colors.green, // Change color based on revealed state
              child: Center(child: Text(players[index])),
            ),
          );
        },
      ),
    );
  }
}
