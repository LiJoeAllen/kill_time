import 'package:flutter/widgets.dart';

import '../components/block/CombinBlock.dart';
import '../components/block/MoveBlock.dart';
import '../components/block/NewBlock.dart';
import '../components/block/StaticBlock.dart';
import '../store/BlockInfo.dart';

class BlockFactory {
  late AnimationController combinController;
  late AnimationController addController;
  late AnimationController moveController;
  late int _mode;

  BlockFactory(TickerProvider provider, int mode) {
    combinController = AnimationController(
        duration: const Duration(milliseconds: 60), vsync: provider);
    addController = AnimationController(
        duration: const Duration(milliseconds: 80), vsync: provider);
    moveController = AnimationController(
        duration: const Duration(milliseconds: 95), vsync: provider);
    _mode = mode;
  }

  Widget create(BlockInfo info) {
    if (info.isNew) {
      return NewBlock(
        info: info,
        controller: addController,
      );
    }

    if (info.needMove && info.needCombine) {
      return ComBinBlock(
        info: info,
        mode: _mode,
        comBinController: combinController,
        moveController: moveController,
      );
    }

    if (info.needMove && info.needCombine != true) {
      return MoveBlock(info: info, mode: _mode, controller: moveController);
    }

    return StaticBlock(
      info: info,
      controller: addController,
      key: null,
    );
  }

  play() {
    moveController.forward().whenComplete(() {
      addController.forward();
      combinController.forward().whenComplete(() {
        combinController.reverse();
      });
    });
  }
}
