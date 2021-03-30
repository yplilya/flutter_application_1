import 'package:flutter/material.dart';

import 'tic_tac_toe.dart';
import 'snake.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>

/*class MyApp extends StatelessWidget*/ {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: RaisedButton(
                child: Text(
                  'TIC TAC TOE',
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TicTacToe()));
                },
              ),
            ),
            Expanded(
              child: TextButton(
                child: Text(
                  'SNAKE',
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Snake()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
