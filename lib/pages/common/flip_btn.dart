import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class FlipBtn extends StatelessWidget {
  final AssetImage imageFile;
  final dynamic onFlip;
  const FlipBtn({super.key, required this.imageFile, required this.onFlip});

  @override
  Widget build(BuildContext context) {

    return FlipCard(
      flipOnTouch: true,
      direction: FlipDirection.VERTICAL,
      side: CardSide.FRONT,
      front: Image(
          image: imageFile,
          fit: BoxFit.fill,
          height: 50,
          width: 180,
        ),
      back: Image(
        image: imageFile,
        fit: BoxFit.fill,
        height: 50,
        width: 180,
      ),
      onFlip: onFlip
    );
  }
}