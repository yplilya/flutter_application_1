import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class Snake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SnakeGame(),
    );
  }
}

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  final int squersPerRow = 20;
  final int squersPerColumn = 40;
  final fontStyle = TextStyle(color: Colors.white, fontSize: 20);
  final randomGen = Random();

  var snake = [
    [0, 1],
    [0, 0]
  ];
  var food = [0, 2];
  var direction = 'up';
  var isPlaying = false;

  void startGame() {
    const duration = Duration(milliseconds: 300);

    snake = [
      [(squersPerRow / 2).floor(), (squersPerColumn).floor()]
    ];

    snake.add([snake.first[0], snake.first[1] - 1]);

    createFood();

    isPlaying = true;
    Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (checkGameOver()) {
        timer.cancel();
        endGame();
      }
    });
  }

  bool checkGameOver() {
    if (!isPlaying ||
        snake.first[1] < 0 ||
        snake.first[1] >= squersPerColumn ||
        snake.first[0] < 0 ||
        snake.first[0] >= squersPerRow) {
      return true;
    }

    for (var i = 1; i < snake.length; ++i) {
      if (snake[i][0] == snake.first[0] && snake.first[1] == snake[i][1]) {
        return true;
      }
    }

    return false;
  }

  void endGame() {
    isPlaying = false;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text(
              'Score: ${snake.length - 2}',
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    snake = [
      [0, 1],
      [0, 0]
    ];
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case 'up':
          snake.insert(0, [snake.first[0], snake.first[1] - 1]);
          break;

        case 'down':
          snake.insert(0, [snake.first[0], snake.first[1] + 1]);
          break;

        case 'left':
          snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
          break;

        case 'right':
          snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
          break;
      }

      if (snake.first[0] != food[0] || snake.first[1] != food[1]) {
        snake.removeLast();
      }
    });
  }

  void createFood() {
    food = [
      randomGen.nextInt(squersPerRow),
      randomGen.nextInt(squersPerColumn)
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) {
                  direction = 'right';
                } else if (direction != 'right' && details.delta.dx < 0) {
                  direction = 'left';
                }
              },
              child: AspectRatio(
                aspectRatio: squersPerRow / (squersPerColumn + 5),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: squersPerRow),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: squersPerColumn * squersPerColumn,
                  itemBuilder: (BuildContext context, int index) {
                    var color;
                    var x = index % squersPerRow;
                    var y = (index / squersPerRow).floor();

                    bool isSnakeBody = false;
                    for (var pos in snake) {
                      if (pos[0] == x && pos[1] == y) {
                        isSnakeBody = true;
                        break;
                      }
                    }

                    if (snake.first[0] == x && snake.first[1] == y) {
                      color = Colors.green;
                    } else if (isSnakeBody) {
                      color = Colors.green[200];
                    } else if (food[0] == x && food[1] == y) {
                      color = Colors.red;
                    } else {
                      color = Colors.grey[800];
                    }

                    return Container(
                      margin: EdgeInsets.all(1),
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  //color: isPlaying ? Colors.red : Colors.blue,
                  child: Text(
                    isPlaying ? 'End' : 'Start',
                    style: fontStyle,
                  ),
                  onPressed: () {
                    if (isPlaying) {
                      isPlaying = false;
                    } else {
                      startGame();
                    }
                  },
                ),
                Text(
                  'Score: ${max(snake.length - 2, 0)}',
                  style: fontStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
