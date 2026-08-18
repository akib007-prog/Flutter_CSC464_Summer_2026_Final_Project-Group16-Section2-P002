import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/game_provider.dart';
import 'game_board_screen.dart';
import 'match_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final p1Controller = TextEditingController();
  final p2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MatchHistoryScreen())),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: p1Controller, decoration: const InputDecoration(labelText: "Player 1 Name (X)")),
            const SizedBox(height: 12),
            TextField(controller: p2Controller, decoration: const InputDecoration(labelText: "Player 2 Name (O)")),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<GameProvider>().updatePlayerNames(
                  p1Controller.text.isEmpty ? "Player 1" : p1Controller.text,
                  p2Controller.text.isEmpty ? "Player 2" : p2Controller.text,
                );
                Navigator.push(context, MaterialPageRoute(builder: (_) => const GameBoardScreen()));
              },
              child: const Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }
}