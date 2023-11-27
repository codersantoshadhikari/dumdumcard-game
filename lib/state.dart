import 'package:flutter/material.dart';

class MainDataWidget extends InheritedWidget{
  final int highscore;

  const MainDataWidget ({super.key, 
    required super.child,
    required this.highscore,
  });

  @override
  bool updateShouldNotify(MainDataWidget oldWidget) => oldWidget != highscore;
}