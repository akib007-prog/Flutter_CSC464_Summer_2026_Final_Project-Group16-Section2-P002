import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/game_provider.dart';
import 'game_board_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    String resultText = game.isTie
        ? "It's a Tie!"
        : "${game.winner == "X" ? game.player1Name : game.player2Name} Wins!";

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(resultText, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<GameProvider>().resetGame();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GameBoardScreen()));
              },
              child: const Text("Play Again"),
            ),
          ],
        ),
      ),
    );
  }
}