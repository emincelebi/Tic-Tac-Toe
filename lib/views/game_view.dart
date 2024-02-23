import 'package:flutter/material.dart';
import 'package:tic_tac_toe/views/home.dart';
import 'package:tic_tac_toe/widgets/tic_tac_container.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late List<List<String>> board;
  int currentPlayer = 0;
  String winner = "";

  @override
  void initState() {
    board = List.generate(3, (_) => List.filled(3, ""));
    super.initState();
  }

  String controlTap(int row, int col) {
    if (board[row][col] != '') {
      return '';
    } else {
      setState(() {
        board[row][col] = currentPlayer == 0 ? "X" : "O";
        currentPlayer = 1 - currentPlayer;
        winner = checkWinner();
      });
      if (winner.isNotEmpty || board[row][col].isNotEmpty) return winner;

      return '';
    }
  }

  String checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] && board[i][0] == board[i][2] && board[i][0].isNotEmpty) {
        return board[i][0];
      }
    }

    for (int i = 0; i < 3; i++) {
      if (board[0][i] == board[1][i] && board[0][i] == board[2][i] && board[0][i].isNotEmpty) {
        return board[0][i];
      }
    }

    if (board[0][0] == board[1][1] && board[0][0] == board[2][2] && board[0][0].isNotEmpty) {
      return board[0][0];
    }

    if (board[0][2] == board[1][1] && board[0][2] == board[2][0] && board[0][2].isNotEmpty) {
      return board[0][2];
    }

    bool draw = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          draw = false;
          break;
        }
      }
    }
    if (draw) {
      return "Draw";
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: currentPlayer == 0 ? Colors.red : Colors.blue,
      appBar: AppBar(
        backgroundColor: currentPlayer == 0 ? Colors.red : Colors.blue,
        centerTitle: true,
        title: Text(
          'Tic Tac Toe',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          final row = index ~/ 3;
          final col = index % 3;
          return GestureDetector(
            onTap: () {
              var response = controlTap(row, col);
              if (response != '') {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Result: $response'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      currentPlayer = 0;
                                      for (int i = 0; i < 3; i++) {
                                        for (int j = 0; j < 3; j++) {
                                          board[i][j] = '';
                                        }
                                      }
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Retry'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => const HomePage()),
                                        (route) => false);
                                  },
                                  child: const Text('Home'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: TicTacToeContainer(value: board[row][col]),
          );
        },
      ),
    );
  }
}
