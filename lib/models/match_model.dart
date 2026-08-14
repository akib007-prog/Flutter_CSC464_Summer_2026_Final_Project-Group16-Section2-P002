import 'package:cloud_firestore/cloud_firestore.dart';

class MatchModel {
  final String player1;
  final String player2;
  final String winner;
  final List<String> board;
  final DateTime createdAt;

  MatchModel({
    required this.player1,
    required this.player2,
    required this.winner,
    required this.board,
    required this.createdAt,
  });

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      player1: map['player1'],
      player2: map['player2'],
      winner: map['winner'],
      board: List<String>.from(map['board']),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'player1': player1,
      'player2': player2,
      'winner': winner,
      'board': board,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}