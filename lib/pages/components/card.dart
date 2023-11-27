import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class CardLoader extends StatefulWidget {
  final List cardState;
  final int zz;
  final List cards;
  final int col;
  final GlobalKey<FlipCardState>? thisCard;
  final GlobalKey<FlipCardState>? card1;
  final GlobalKey<FlipCardState>? card2;

  const CardLoader({super.key, required this.cardState, required this.zz, required this.cards, required  this.col, required this.thisCard, required this.card1, required this.card2});

  @override
  State<CardLoader> createState() => _CardLoaderState();
}

class _CardLoaderState extends State<CardLoader> {
  @override
  Widget build(BuildContext context) {
    List cardState = widget.cardState;
    int zz = widget.zz;
    List cards = widget.cards;
    int col = widget.col;
    GlobalKey<FlipCardState>? thisCard = widget.thisCard;
    GlobalKey<FlipCardState>? card1 = widget.card1;
    GlobalKey<FlipCardState>? card2 = widget.card2;

    return FlipCard(
      key: thisCard,
      //autoFlipDuration: const Duration(seconds: 1),
      flipOnTouch: false,
      speed: 400,
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      autoFlipDuration: const Duration(milliseconds: 800),
      front: Container(
        padding: const EdgeInsets.symmetric(vertical:10),
        // color: Colors.white,
        child: AnimatedOpacity(
          opacity: cardState[zz] == true ? 1.0: 0.0,
          duration: const Duration(milliseconds: 500),
          child: Image(
            image: AssetImage("assets/images/symbols/${cards[zz]}.png"),
            fit: BoxFit.fill,
            width: ((MediaQuery.of(context).size.width-50)/col)-20,
          ),
        ),
      ),
      back: 
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero
        ),
        child: Image.asset(
          "assets/images/backgrounds/backCard.png",
          fit: BoxFit.fill,
          height: ((MediaQuery.of(context).size.height-300)/col)-20,
          width: ((MediaQuery.of(context).size.width-40)/col)-20,
        ),
        
        onPressed: () {
          if(card1 == null){
            thisCard?.currentState?.toggleCard();
            card1 = thisCard;
          } else {
            thisCard?.currentState?.toggleCard();
            card2 = thisCard;
            // check();
          }
        },
      )
    );
  }
}