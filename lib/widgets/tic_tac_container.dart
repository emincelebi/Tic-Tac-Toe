import 'package:flutter/material.dart';

class TicTacToeContainer extends StatelessWidget {
  final String value;

  const TicTacToeContainer({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Center(
        child: Text(
          value,
          style: const TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}
