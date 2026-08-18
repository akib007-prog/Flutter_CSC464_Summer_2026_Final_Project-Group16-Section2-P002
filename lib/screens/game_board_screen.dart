import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/game_provider.dart';
import 'result_screen.dart';

class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();

    if (game.winner != null || game.isTie) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ResultScreen()));
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text("${game.player1Name} (X) vs ${game.player2Name} (O)")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Turn: ${game.currentPlayer == "X" ? game.player1Name : game.player2Name}",
                style: const TextStyle(fontSize: 18)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("X Wins: ${game.xWins}"),
              Text("O Wins: ${game.oWins}"),
              Text("Ties: ${game.ties}"),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => context.read<GameProvider>().makeMove(index),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Center(
                    child: Text(game.board[index], style: const TextStyle(fontSize: 32)),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}