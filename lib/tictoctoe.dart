import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/theme/color.dart';
import 'package:tictactoe/utils/game_logic.dart';
import 'package:tictactoe/utils/selectuser.dart';

int players = 0;
int player1 = 0;
int player2 = 0;
int computer = 0;

class TicTocToe extends StatefulWidget {
  const TicTocToe({Key? key}) : super(key: key);

  @override
  _TicTocToeState createState() => _TicTocToeState();
}

class _TicTocToeState extends State<TicTocToe> {
  String lastValue = "X";
  Game game = Game();
  int turn = 0;
  String result = "";
  bool gameOver = false;
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: const EdgeInsets.only(left: 12.0, top: 10, bottom: 10),
                icon: const Icon(Icons.home, size: 45, color: Colors.white),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectUser()),
                      (route) => false);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Text(
                  "Joueur 1: $player1",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              players == 2
                  ? Padding(
                      padding: const EdgeInsets.only(top: 28.0, right: 40),
                      child: Text(
                        "Joueur 2: $player2",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 28.0, right: 40),
                      child: Text(
                        "Computer: $computer",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            " C'est à  $lastValue  de jouer ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/ 3,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(
                Game.boardlenth,
                (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = lastValue;
                                turn++;
                                gameOver = game.winnerCheck(
                                    lastValue, index, scoreboard, 3);

                                if (gameOver) {
                                  result = "$lastValue is the winner";
                                  setState(() {
                                    lastValue == "X"
                                        ? player1 += 1
                                        : player2 += 1;
                                  });
                                } else if (!gameOver && turn == 9) {
                                  result = "It's a Draw!";
                                  gameOver = true;
                                }
                                if (lastValue == 'X') {
                                  lastValue = "O";
                                } else {
                                  lastValue = "X";
                                }
                              });
                            }
                            if (gameOver == false) {
                              if (players == 1) {
                                Future.delayed(Duration(milliseconds: 500))
                                    .then((value) {
                                  do {
                                    index = entierAleatoire(0, 8);
                                  } while (game.board![index] == "X" ||
                                      game.board![index] == "O");

                                  if (game.board![index] == "") {
                                    setState(() {
                                      game.board![index] = lastValue;
                                      turn++;
                                      gameOver = game.winnerCheck(
                                          lastValue, index, scoreboard, 3);

                                      if (gameOver) {
                                        result = " $lastValue  a gangé";
                                        setState(() {
                                          lastValue == "X"
                                              ? player1 += 1
                                              : computer += 1;
                                        });
                                      } else if (!gameOver && turn == 9) {
                                        result = "Match Nul";
                                        gameOver = true;
                                      }
                                      if (lastValue == 'X') {
                                        lastValue = "O";
                                      } else {
                                        lastValue = "X";
                                      }
                                    });
                                  }
                                });
                              }
                            }
                          },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            result,
            style: const TextStyle(color: Colors.white, fontSize: 54.0),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.replay),
            label: const Text("Replay the Game"),
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
          ),
        ],
      ),
    );
  }
}

int entierAleatoire(min, max) {
  var x;
  x = ((Random().nextDouble() * (max - min + 1)) + min).floor();
  return x;
}
