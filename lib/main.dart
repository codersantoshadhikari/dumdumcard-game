import 'package:flutter/material.dart';
import 'package:dumdumcard/pages/loading.dart';
import 'package:dumdumcard/pages/screen.dart';
import 'package:dumdumcard/pages/game.dart';
import 'package:dumdumcard/pages/leaderboard.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '.',
    routes: {
      '.':(context) => const Loading(),
      './screen': (context) =>  const Screen(),
      './game': (context) =>  const Game(),
      './leaderboard': (context) =>  const LeaderBoard()
    },
  ));
}