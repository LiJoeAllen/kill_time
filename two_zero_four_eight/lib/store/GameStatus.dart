/// 当前状态
class GameStatus {
  GameStatus({
    required this.adds,
    required this.moves,
    required this.scores,
    required this.total,
    required this.end,
  });

  int scores;
  int total;
  int adds;
  int moves;
  bool end;
}
