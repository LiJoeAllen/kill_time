import 'package:redux/redux.dart';
import 'package:two_zero_four_eight/reducers/updateState.dart';

import './moveDown.dart';
import './moveLeft.dart';
import './moveRight.dart';
import './moveUp.dart';
import '../store/GameState.dart';

final gameReducer = combineReducers<GameState>([
  TypedReducer<GameState, UpdateStateAction>(updateState),
  TypedReducer<GameState, MoveLeftAction>(moveLeft),
  TypedReducer<GameState, MoveRightAction>(moveRight),
  TypedReducer<GameState, MoveUpAction>(moveUp),
  TypedReducer<GameState, MoveDownAction>(moveDown),
]);
