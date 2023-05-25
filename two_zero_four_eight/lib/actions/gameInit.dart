import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../reducers/updateState.dart';
import '../store/GameState.dart';
import '../store/GameStatus.dart';

gameInit(Store<GameState> store, int mode) async {
  SharedPreferences refs = await SharedPreferences.getInstance();

  var key = 'total_$mode';

  if (store.state.status.scores > store.state.status.total) {
    refs.setInt(key, store.state.status.scores);
  }
  var state = GameState.initial(mode);

  state.status = GameStatus(
    adds: 0,
    end: false,
    moves: 0,
    total: refs.getInt(key) ?? 0,
    scores: 0,
  );

  store.dispatch(UpdateStateAction(state));
}
