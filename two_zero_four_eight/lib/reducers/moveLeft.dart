import '../store/GameState.dart';

class MoveLeftAction {}

GameState moveLeft(GameState state, MoveLeftAction action) {
  if (state.status.end) return state.clone();

  var cloneState = state.clone();
  int i, j, k;
  bool isMoved = false;
  bool haveMove = false;
  bool haveComBin = false;
  for (i = 0; i < cloneState.mode; i++) {
    j = k = 0;
    while (true) {
      while (j < cloneState.mode && cloneState.getBlock(i, j).value == 0) {
        j++;
      }
      if (j > cloneState.mode - 1) break;

      if (j > k) {
        isMoved = haveMove = true;
        var block = cloneState.getBlock(i, j);
        block.needMove = true;
        block.needCombine = false;
        cloneState.swapBlock(i * cloneState.mode + k, i * cloneState.mode + j);
      }

      if (k > 0 &&
          cloneState.getBlock(i, k).value ==
              cloneState.getBlock(i, k - 1).value &&
          cloneState.getBlock(i, k - 1).needCombine != true) {
        var currentBlock = cloneState.getBlock(i, k);
        var prevBlock = cloneState.getBlock(i, k - 1);
        prevBlock.before =
            isMoved ? currentBlock.before : (i * cloneState.mode + k);
        prevBlock.current = i * cloneState.mode + k - 1;
        prevBlock.needMove = true;
        prevBlock.needCombine = haveComBin = true;
        prevBlock.value <<= 1;
        cloneState.status.scores += prevBlock.value;
        currentBlock.reset();
        currentBlock.current = currentBlock.before = i * cloneState.mode + k;
      } else {
        k++;
      }
      j++;
    }
  }

  if (haveMove || haveComBin) {
    cloneState.update();
  }
  return cloneState;
}
