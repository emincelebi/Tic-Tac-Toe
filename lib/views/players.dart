import 'package:flutter/material.dart';
import 'package:tic_tac_toe/views/home.dart';
import 'package:tic_tac_toe/widgets/tic_tac_container.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({Key? key, required this.player1, required this.player2}) : super(key: key);
  final String player1;
  final String player2;

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late final List<List<String>> board;
  int p1Score = 0;
  int p2Score = 0;
  int currentPlayer = 0;
  String winner = '';
  String response = '';

  @override
  void initState() {
    super.initState();
    board = List.generate(3, (_) => List.filled(3, ''));
  }

  String controlTap(int row, int col) {
    if (board[row][col].isNotEmpty) {
      return '';
    }

    setState(() {
      board[row][col] = currentPlayer == 0 ? 'X' : 'O';
      currentPlayer = 1 - currentPlayer;
      winner = checkWinner();
      if (winner == 'X') {
        currentPlayer = 0;
        for (int i = 0; i < 3; i++) {
          for (int j = 0; j < 3; j++) {
            board[i][j] = '';
          }
        }
        p1Score++;
      } else if (winner == 'O') {
        currentPlayer = 0;
        for (int i = 0; i < 3; i++) {
          for (int j = 0; j < 3; j++) {
            board[i][j] = '';
          }
        }
        p2Score++;
      }
    });

    return '';
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
      currentPlayer = 0;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          board[i][j] = '';
        }
      }
      return 'Draw';
    }

    return '';
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
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
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
                  response = controlTap(row, col);
                  if (response.isNotEmpty) {
                    if (response == 'X') {
                      response = widget.player1;
                    } else if (response == 'O') {
                      response = widget.player2;
                    }
                  }
                },
                child: TicTacToeContainer(value: board[row][col]),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    widget.player1,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    '$p1Score',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.player2,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    '$p2Score',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }
}
