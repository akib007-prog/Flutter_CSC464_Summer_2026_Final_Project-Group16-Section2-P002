import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/game_provider.dart';
import '../models/match_model.dart';

class MatchHistoryScreen extends StatelessWidget {
  const MatchHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.read<GameProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Match History")),
      body: StreamBuilder<List<MatchModel>>(
        stream: gameProvider.getMatchHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final matches = snapshot.data!;
          if (matches.isEmpty) return const Center(child: Text("No matches yet"));
          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, i) {
              final m = matches[i];
              return ListTile(
                title: Text("${m.player1} vs ${m.player2}"),
                subtitle: Text("Winner: ${m.winner}"),
                trailing: Text("${m.createdAt.hour}:${m.createdAt.minute}"),
              );
            },
          );
        },
      ),
    );
  }
}