import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = false;
  List<String> displayExOh = ['', '', '', '', '', '', '', '', ''];
  int countFilled = 0;

  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey[900],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[600])),
                      child: Center(
                        child: Text(
                          displayExOh[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[900],
            ),
          ),
        ]));
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'o';
        ohTurn = !ohTurn;
        countFilled++;
        _checkWinner();
      } else if (displayExOh[index] == '') {
        displayExOh[index] = 'x';
        ohTurn = !ohTurn;
        countFilled++;
        _checkWinner();
      }
    });
  }

  void _checkWinner() {
    for (int i = 0; i < 3; ++i) {
      if (displayExOh[i * 3] == displayExOh[i * 3 + 1] &&
          displayExOh[i * 3 + 2] == displayExOh[i * 3] &&
          displayExOh[i * 3] != '') {
        _showWinDialog(i * 3);
      } else if (displayExOh[i] == displayExOh[i + 3] &&
          displayExOh[i + 6] == displayExOh[i] &&
          displayExOh[i] != '') {
        _showWinDialog(i);
      }
    }
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showWinDialog(0);
    }
    if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != '') {
      _showWinDialog(2);
    }
    if (countFilled == 9) {
      _showWinDialog(countFilled);
    }
  }

  void _showWinDialog(int index) {
    if (index == 9) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text(
                  "DRAW!",
                  style: TextStyle(color: Colors.grey[900]),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "PLAY AGAIN!",
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                    onPressed: () {
                      _clearTheBoard();
                      Navigator.of(context).pop();
                    },
                  )
                ]);
          });
    } else if (displayExOh[index] == 'x') {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text(
                  "WINNER IS PLAYER X!",
                  style: TextStyle(color: Colors.grey[900]),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "PLAY AGAIN!",
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                    onPressed: () {
                      _clearTheBoard();
                      Navigator.of(context).pop();
                    },
                  )
                ]);
          });
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text(
                  "WINNER IS PLAYER O!",
                  style: TextStyle(color: Colors.grey[800]),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "PLAY AGAIN!",
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    onPressed: () {
                      _clearTheBoard();
                      Navigator.of(context).pop();
                    },
                  )
                ]);
          });
    }
  }

  void _clearTheBoard() {
    setState(() {
      for (int i = 0; i < 9; ++i) {
        displayExOh[i] = '';
      }
    });
    countFilled = 0;
  }
}
