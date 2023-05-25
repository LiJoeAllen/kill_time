import 'package:flutter/material.dart';
import 'package:public/main.dart';

import 'components/GameStage.dart';
import 'components/ViewScaffold.dart';

void main() => runApp(const GameApp());

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<StatefulWidget> createState() => GameAppState();
}

class GameAppState extends State<GameApp> {
  @override
  Widget build(BuildContext context) {
    log.d("开始");
    return const ViewScaffold(
      children: <Widget>[
        GameStage(),
      ],
    );
  }
}
