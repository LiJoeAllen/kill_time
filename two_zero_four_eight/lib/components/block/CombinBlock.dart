import 'package:flutter/material.dart';

import '../../store/BlockInfo.dart';
import '../NumberText.dart';
import 'BaseBlock.dart';
import 'MoveBlock.dart';

class ComBinBlock extends BaseBlock {
  final BlockInfo info;
  final int mode;
  final AnimationController moveController;

  ComBinBlock({
    Key? key,
    required this.info,
    required this.mode,
    required this.moveController,
    required AnimationController comBinController,
  }) : super(
          key: key,
          animation:
              Tween<double>(begin: 1, end: 1.25).animate(comBinController),
        );

  @override
  Widget buildBlock(BuildContext context, BlockProps props) {
    Animation<double> animation = listenable as Animation<double>;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        MoveBlock(
          info: BlockInfo(
            isNew: false,
            value: info.value ~/ 2,
            before: info.before,
            current: info.current,
          ),
          mode: mode,
          controller: moveController,
          key: key,
        ),
        Positioned(
          top: (info.current ~/ props.mode) *
              (props.blockWidth + props.borderWidth),
          left: (info.current % props.mode) *
              (props.blockWidth + props.borderWidth),
          child: Transform.scale(
            scale: animation.value,
            origin: const Offset(0.5, 0.5),
            child: NumberText(value: info.value, size: props.blockWidth),
          ),
        )
      ],
    );
  }
}
