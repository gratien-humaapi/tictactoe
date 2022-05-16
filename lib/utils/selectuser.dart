import 'package:flutter/material.dart';
import 'package:tictactoe/tictoctoe.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  _SelectUserState createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 400,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          Container(
            width: 160,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              border: Border.all(
                color: Colors.black,
                width: 4,
              ),
            ),
            padding: const EdgeInsets.all(8),

            // ignore: deprecated_member_use
            child: FlatButton(
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Jouer',
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              onPressed: () {
                players = 1;
                player1 = 0;
                player2 = 0;
                computer = 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TicTocToe(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Container(
            width: 140,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red[400],
              border: Border.all(
                color: Colors.black,
                width: 4,
              ),
            ),
            padding: const EdgeInsets.all(5),
            // ignore: deprecated_member_use
            child: FlatButton(
              child: const Center(
                child: Text(
                  '2 Joueurs',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              onPressed: () {
                players = 2;
                player1 = 0;
                player2 = 0;
                computer = 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TicTocToe(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
