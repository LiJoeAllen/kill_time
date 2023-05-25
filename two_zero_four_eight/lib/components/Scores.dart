import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../actions/gameInit.dart';
import '../store/GameState.dart';

class Scores extends StatelessWidget {
  const Scores({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, ScoresProps>(
      converter: (store) => ScoresProps(
        scores: store.state.status.scores,
        total: store.state.status.total,
        isEnd: store.state.status.end,
        reset: () {
          gameInit(store, store.state.mode);
        },
        mode: 0,
      ),
      onDidChange: (previousViewModel, viewModel) {
        if (previousViewModel!.isEnd &&
            previousViewModel.scores > previousViewModel.total) {
          SharedPreferences.getInstance().then((refs) {
            refs.setInt(
                'total_${previousViewModel.mode}', previousViewModel.scores);
          });
        }
      },
      builder: (context, props) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  '2048',
                  style: TextStyle(
                      fontSize: 50,
                      color: Color(0xff776e65),
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(23, 5, 23, 5),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffbbada0),
                        border: Border.all(color: Colors.transparent, width: 0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            // 'SCORE',
                            '得分',
                            style: TextStyle(
                                color: Color(0xffeee4da),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            props.scores.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(23, 5, 23, 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffbbada0),
                        border: Border.all(color: Colors.transparent, width: 0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            // 'BEST',
                            '记录',
                            style: TextStyle(
                                color: Color(0xffeee4da),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            props.total.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Play 2048 Game flutter',
                      style: TextStyle(
                          color: Color(0xff776e65),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      // 'Join and get to the 2048 tile!',
                      '进入对局',
                      style: TextStyle(color: Color(0xff776e65)),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => props.reset(),
                  child: const Text(
                    // 'New Game',
                    '新游戏',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class ScoresProps {
  ScoresProps(
      {required this.mode,
      required this.total,
      required this.scores,
      required this.isEnd,
      required this.reset});

  int mode;
  int total;
  int scores;
  bool isEnd;
  Function reset;
}
