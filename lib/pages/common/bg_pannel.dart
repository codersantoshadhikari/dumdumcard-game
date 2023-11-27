import 'package:flutter/material.dart';

class BgPannel extends StatelessWidget {
  
  final Widget? child;
  final double? height;

  const BgPannel({super.key, this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(35),
          constraints: const BoxConstraints(
            minHeight: 450,
            minWidth: double.infinity
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/pannel.png"),
              fit: BoxFit.fill
            )
          ),
          child: child,
        ),
      ]
    );
  }
}