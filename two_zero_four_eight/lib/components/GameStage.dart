import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import './GameBg.dart';
import './ModeSelector.dart';
import './Playground.dart';
import '../actions/gameInit.dart';
import '../constants/Display.dart';
import '../reducers/index.dart';
import '../store/GameState.dart';
import 'Blocks.dart';
import 'Scores.dart';

class GameStage extends StatelessWidget {
  const GameStage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return StoreProvider(
      store: Store<GameState>(
        gameReducer,
        middleware: [thunkMiddleware],
        initialState: GameState.initial(4),
      ),
      child: StoreConnector<GameState, GameProps>(
        converter: (store) =>
            GameProps(started: store.state.status.total != null),
        onInit: (store) {
          gameInit(store, 4);
        },
        builder: (context, props) {
          return props.started
              ? Container(
                  margin: EdgeInsets.all(Display.borderMargin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ModeSelector(),
                      const Scores(),
                      const Stack(
                        children: <Widget>[
                          GameBg(),
                          Blocks(),
                          Playground(),
                        ],
                      ),
                    ],
                  ),
                )
              : Container();
        },
      ),
    );
  }
}

class GameProps {
  bool started;

  GameProps({required this.started});
}
