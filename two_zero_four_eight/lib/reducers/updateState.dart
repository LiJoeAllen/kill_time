import '../store/GameState.dart';

class UpdateStateAction {
  GameState state;

  UpdateStateAction(this.state);
}

GameState updateState(GameState state, UpdateStateAction action) {
  return action.state;
}
