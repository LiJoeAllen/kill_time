import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../store/BlockInfo.dart';
import '../NumberText.dart';
import 'BaseBlock.dart';

class StaticBlock extends BaseBlock {
  final BlockInfo info;

  StaticBlock({
    required super.key,
    required this.info,
    required AnimationController controller,
  }) : super(
          animation: Tween<double>(begin: 0.0, end: 0.0).animate(controller),
        );

  @override
  Widget buildBlock(BuildContext context, BlockProps props) {
    return Positioned(
      top:
          (info.current ~/ props.mode) * (props.blockWidth + props.borderWidth),
      left:
          (info.current % props.mode) * (props.blockWidth + props.borderWidth),
      child: NumberText(value: info.value, size: props.blockWidth),
    );
  }
}
