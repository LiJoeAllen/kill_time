import '../store/GameState.dart';

class MoveDownAction {}

GameState moveDown(GameState state, MoveDownAction action) {
  if (state.status.end) return state.clone();

  var cloneState = state.clone();
  int i, j, k;
  bool isMoved = false;
  bool haveMove = false;
  bool haveComBin = false;
  for (i = 0; i < cloneState.mode; i++) {
    j = k = cloneState.mode - 1;
    while (true) {
      while (j > -1 && cloneState.getBlock(j, i).value == 0) {
        j--;
      }
      if (j < 0) break;

      if (j < k) {
        isMoved = haveMove = true;
        var block = cloneState.getBlock(j, i);
        block.needMove = true;
        block.needCombine = false;
        cloneState.swapBlock(k * cloneState.mode + i, j * cloneState.mode + i);
      }

      if (k < cloneState.mode - 1 &&
          cloneState.getBlock(k, i).value ==
              cloneState.getBlock(k + 1, i).value &&
          !cloneState.getBlock(k + 1, i).needCombine) {
        var currentBlock = cloneState.getBlock(k, i);
        var prevBlock = cloneState.getBlock(k + 1, i);
        prevBlock.before =
            isMoved ? currentBlock.before : (k * cloneState.mode + i);

        prevBlock.current = (k + 1) * cloneState.mode + i;
        prevBlock.needMove = true;
        prevBlock.needCombine = haveComBin = true;
        prevBlock.value <<= 1;
        cloneState.status.scores += prevBlock.value;
        currentBlock.reset();
        currentBlock.current = currentBlock.before = k * cloneState.mode + i;
      } else {
        k--;
      }
      j--;
    }
  }

  if (haveMove || haveComBin) {
    cloneState.update();
  }
  return cloneState;
}
