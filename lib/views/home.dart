import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/views/game_view.dart';
import 'package:tic_tac_toe/views/players.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _c1;
  late final TextEditingController _c2;

  @override
  void initState() {
    _c1 = TextEditingController();
    _c2 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GameView()));
                },
                child: const Text('Fast Game')),
            ElevatedButton(
                onPressed: () {
                  _c1.clear();
                  _c2.clear();
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Player 1:'),
                            TextField(
                              controller: _c1,
                            ),
                            const Text('Player 2:'),
                            TextField(
                              controller: _c2,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayerView(
                                        player1: _c1.text,
                                        player2: _c2.text,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Play'))
                          ],
                        ),
                      ));
                    },
                  );
                },
                child: const Text('Long Game')),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: const Text('Exit', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
