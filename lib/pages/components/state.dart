import 'package:flutter/material.dart';

class StateWidget extends StatefulWidget {
  final Widget child;

  const StateWidget({super.key, required this.child});

  @override
  State<StateWidget> createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  int highscore = 0;

  void incrementCounter(hs) {
    hs++;
    setState(() {
      highscore = hs;
    });
  }

  @override
  Widget build(BuildContext context) => MainDataWidget(
    child: widget.child, 
    highscore: highscore,
    stateWidget: this,
  );
}


class MainDataWidget extends InheritedWidget{
  final int highscore;
  final _StateWidgetState stateWidget;

  const MainDataWidget ({
    Key? key,
    required Widget child,
    required this.highscore,
    required this.stateWidget,
  }) : super(key: key, child: child);

  static _StateWidgetState of(BuildContext context) => context
    .dependOnInheritedWidgetOfExactType<MainDataWidget>()
    !.stateWidget
  ;

  @override
  bool updateShouldNotify(MainDataWidget oldWidget) => oldWidget.highscore != highscore;
}