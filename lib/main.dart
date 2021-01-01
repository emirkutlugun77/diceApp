import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: DiceApp(),
  ));
}

class DiceApp extends StatefulWidget {
  @override
  _DiceAppState createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  int player1Dice1 = 1;
  int player1Dice2 = 1;
  int player2Dice1 = 1;
  int player2Dice2 = 1;
  bool player1Rolled = false;
  bool player2Rolled = false;
  String winner;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Player1',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Text(
                    'Player2',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 70,
                  height: 100,
                  child: Center(
                    child: Image(
                      image: AssetImage('images/dice$player1Dice1.png'),
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  height: 100,
                  child: Center(
                    child: Image(
                      image: AssetImage('images/dice$player1Dice2.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                ),
                Container(
                  width: 70,
                  height: 100,
                  child: Center(
                    child: Image(
                      image: AssetImage('images/dice$player2Dice1.png'),
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  height: 100,
                  child: Center(
                    child: Image(
                      image: AssetImage('images/dice$player2Dice2.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
              child: player1Rolled && player2Rolled
                  ? GestureDetector(
                      onTap: () {
                        if (player1Dice1 + player1Dice2 >
                            player2Dice1 + player2Dice2) {
                          setState(() {
                            winner = 'player1';
                          });
                        }
                        if (player1Dice1 + player1Dice2 <
                            player2Dice1 + player2Dice2) {
                          setState(() {
                            winner = 'player2';
                          });
                        }
                        if (player1Dice1 + player1Dice2 ==
                            player2Dice1 + player2Dice2) {
                          setState(() {
                            winner = 'draw';
                          });
                        }
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Kazanan!'),
                              content: Text(winner),
                            );
                          },
                        );
                        Future.delayed(Duration(milliseconds: 100))
                            .then((value) {
                          setState(() {
                            player1Dice1 =
                                player1Dice2 = player2Dice1 = player2Dice2 = 1;
                            player1Rolled = player2Rolled = false;
                          });
                        });
                      },
                      child: Icon(FontAwesomeIcons.trophy,
                          size: 40, color: Colors.white),
                    )
                  : null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      player1Dice1 = Random().nextInt(6) + 1;
                      player1Dice2 = Random().nextInt(6) + 1;
                      player1Rolled = true;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blueGrey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      player2Dice1 = Random().nextInt(6) + 1;
                      player2Dice2 = Random().nextInt(6) + 1;
                      player2Rolled = true;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
