import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/game_provider.dart';
import 'game_board_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    final bool isTie = game.isTie;
    final String resultText = isTie
        ? "It's a Tie!"
        : "${game.winner == "X" ? game.player1Name : game.player2Name} Wins!";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isTie ? Icons.handshake_rounded : Icons.emoji_events_rounded,
                size: 96,
                color: isTie ? Colors.grey : const Color(0xFFFFC107),
              ),
              const SizedBox(height: 24),
              Text(
                resultText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    context.read<GameProvider>().resetGame();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GameBoardScreen()));
                  },
                  child: const Text("Play Again", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}