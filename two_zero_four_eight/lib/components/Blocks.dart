import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:two_zero_four_eight/utils/Screen.dart';

import '../service/BlockFactory.dart';
import '../store/BlockInfo.dart';
import '../store/GameState.dart';

class Blocks extends StatefulWidget {
  const Blocks({super.key});

  @override
  BlocksState createState() => BlocksState();
}

class BlocksState extends State<Blocks> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, BlocksProps>(
      converter: (store) => BlocksProps(
        data: store.state.data,
        mode: store.state.mode,
        padding: Screen.getBorderWidth(store.state.mode),
      ),
      builder: (context, props) {
        var blockFactory = BlockFactory(this, props.mode);
        blockFactory.play();
        return Container(
          width: Screen.stageWidth,
          height: Screen.stageWidth,
          padding: EdgeInsets.fromLTRB(props.padding, props.padding, 0, 0),
          child: Stack(
            fit: StackFit.expand,
            children: getBlocks(blockFactory, props),
          ),
        );
      },
    );
  }

  getBlocks(BlockFactory blockFactory, BlocksProps props) {
    var blocks = <Widget>[];
    for (var row in props.data) {
      for (var block in row) {
        if (block.value != 0) {
          blocks.add(blockFactory.create(block));
        }
      }
    }
    return blocks;
  }
}

class BlocksProps {
  int mode;
  double padding;
  List<List<BlockInfo>> data;

  BlocksProps({required this.padding, required this.mode, required this.data});
}
