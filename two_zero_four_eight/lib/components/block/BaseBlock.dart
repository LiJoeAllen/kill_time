import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:two_zero_four_eight/utils/Screen.dart';

import '../../store/GameState.dart';

abstract class BaseBlock extends AnimatedWidget {
  const BaseBlock({Key? key, required Animation animation})
      : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, BlockProps>(
      converter: (store) => BlockProps(
        blockWidth: Screen.getBlockWidth(store.state.mode),
        borderWidth: Screen.getBorderWidth(store.state.mode),
        mode: store.state.mode,
      ),
      builder: buildBlock,
    );
  }

  @protected
  Widget buildBlock(
    BuildContext context,
    BlockProps props,
  );
}

class BlockProps {
  double blockWidth;
  double borderWidth;
  int mode;

  BlockProps(
      {required this.blockWidth,
      required this.borderWidth,
      required this.mode});
}
