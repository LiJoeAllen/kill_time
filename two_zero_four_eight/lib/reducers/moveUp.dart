import '../store/GameState.dart';

class MoveUpAction {}

GameState moveUp(GameState state, MoveUpAction action) {
  if (state.status.end) return state.clone();

  var cloneState = state.clone();
  int i, j, k;
  bool isMoved = false;
  bool haveMove = false;
  bool haveComBin = false;
  for (i = 0; i < cloneState.mode; i++) {
    j = k = 0;
    while (true) {
      while (j < cloneState.mode && cloneState.getBlock(j, i).value == 0) {
        j++;
      }
      if (j > cloneState.mode - 1) break;

      if (j > k) {
        isMoved = haveMove = true;
        var block = cloneState.getBlock(j, i);
        block.needMove = true;
        block.needCombine = false;
        cloneState.swapBlock(k * cloneState.mode + i, j * cloneState.mode + i);
      }

      if (k > 0 &&
          cloneState.getBlock(k, i).value ==
              cloneState.getBlock(k - 1, i).value &&
          cloneState.getBlock(k - 1, i).needCombine != true) {
        var currentBlock = cloneState.getBlock(k, i);
        var prevBlock = cloneState.getBlock(k - 1, i);
        prevBlock.before =
            isMoved ? currentBlock.before : (k * cloneState.mode + i);
        prevBlock.current = (k - 1) * cloneState.mode + i;
        prevBlock.needMove = true;
        prevBlock.needCombine = haveComBin = true;
        prevBlock.value <<= 1;
        cloneState.status.scores += prevBlock.value;
        currentBlock.reset();
        currentBlock.current = currentBlock.before = k * cloneState.mode + i;
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
