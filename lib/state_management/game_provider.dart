import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/match_model.dart';

class GameProvider extends ChangeNotifier {
  List<String> board = List.filled(9, "");
  String currentPlayer = "X";
  String startingPlayer = "X";
  String? winner;
  bool isTie = false;

  String player1Name = "Player 1";
  String player2Name = "Player 2";

  int xWins = 0;
  int oWins = 0;
  int ties = 0;

  final List<List<int>> winCombos = [
    [0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8], [2,4,6],
  ];

  void updatePlayerNames(String p1, String p2) {
    player1Name = p1;
    player2Name = p2;
    notifyListeners();
  }

  void makeMove(int index) {
    if (board[index] != "" || winner != null) return;
    board[index] = currentPlayer;

    checkWinner();
    if (winner == null && !board.contains("")) {
      isTie = true;
      ties++;
    }
    if (winner == null && !isTie) {
      currentPlayer = currentPlayer == "X" ? "O" : "X";
    } else {
      saveMatch();
    }
    notifyListeners();
  }

  void checkWinner() {
    for (var combo in winCombos) {
      String a = board[combo[0]], b = board[combo[1]], c = board[combo[2]];
      if (a != "" && a == b && b == c) {
        winner = a;
        if (a == "X") { xWins++; } else { oWins++; }
        return;
      }
    }
  }

  void resetGame() {
    board = List.filled(9, "");
    startingPlayer = startingPlayer == "X" ? "O" : "X";
    currentPlayer = startingPlayer;
    winner = null;
    isTie = false;
    notifyListeners();
  }

  // Resets the board only. startingPlayer is left untouched, so the same
  // player who started last time starts again.
  void resetBoard() {
    board = List.filled(9, "");
    currentPlayer = startingPlayer;
    winner = null;
    isTie = false;
    notifyListeners();
  }

  // Explicitly toggles who starts next, then clears the board so the new
  // starting player can move first. Kept separate from resetBoard() so a
  // player can reset without switching, or switch as its own action.
  void switchStartingPlayer() {
    startingPlayer = startingPlayer == "X" ? "O" : "X";
    board = List.filled(9, "");
    currentPlayer = startingPlayer;
    winner = null;
    isTie = false;
    notifyListeners();
  }

  // Full reset for leaving to Home: clears the board AND the scoreboard,
  // since a new session on Home may involve different players entirely.
  // Player names are intentionally left as-is; Home screen overwrites them
  // when the next match starts.
  void resetSession() {
    board = List.filled(9, "");
    startingPlayer = "X";
    currentPlayer = "X";
    winner = null;
    isTie = false;
    xWins = 0;
    oWins = 0;
    ties = 0;
    notifyListeners();
  }

  Future<void> saveMatch() async {
    final match = MatchModel(
      player1: player1Name,
      player2: player2Name,
      winner: isTie ? "Tie" : winner!,
      board: board,
      createdAt: DateTime.now(),
    );
    await FirebaseFirestore.instance.collection('matches').add(match.toMap());
  }

  Stream<List<MatchModel>> getMatchHistory() {
    return FirebaseFirestore.instance
        .collection('matches')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => MatchModel.fromMap(d.data())).toList());
  }
}