import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:dumdumcard/pages/common/bg_pannel.dart';
import 'package:dumdumcard/pages/components/timer.dart';
import 'package:dumdumcard/pages/components/card.dart';

class Board extends StatefulWidget {
  final Map data;
  final List cards;
  final int row;
  final int column;
  const Board({super.key, required this.data, required this.cards, required this.row, required this.column});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    Map data = widget.data;
    List cards = widget.cards;
    int row = widget.row;
    int col = widget.column;
    int hs = data['highscore'];

    int solvedCards = 0;

    var cardId = <int, GlobalKey<FlipCardState>>{};
    
    List cardState = [];

    GlobalKey<FlipCardState>? card1;
    GlobalKey<FlipCardState>? card2;

    Future <void> foldCard(cd1, cd2) async {
      Future.delayed(const Duration(milliseconds: 500), (){
        cd2?.currentState?.toggleCard();
        cd1?.currentState?.toggleCard();
        // print('++++++++++++++++++++');
        // print(card2);
        // print(card1);
        // print('++++++++++++++++++++');
      });
    }

    int loadScore(){
      hs = data['highscore'] = solvedCards;
      return hs;
    }

    void playerWinCheck(){
      if(row*col == solvedCards){
        Future.delayed( const Duration(milliseconds: 400),(){
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return  Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: AlertDialog(
                    title: const Text('Congraaaaats'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pair solved: $solvedCards'),
                        const Text('Time: comming soon...'),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
      }
    }

    void check() async {
      int curId = cardId.keys.firstWhere((k) => cardId[k] == card1);
      int lastId = cardId.keys.firstWhere((k) => cardId[k] == card2);
      // print('===================');
      // print('${cards[curId]} == ${cards[lastId]}');
      if(cards[curId] != cards[lastId]){
        await foldCard(card1, card2);
        // print("$card1 | $card2");
      } else {
        solvedCards+=2;
        cardState[curId]=false;
        cardState[lastId]=false;
        loadScore();
      }
      card1 = card2 = null;

      playerWinCheck();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 90, bottom: 20),
      child: BgPannel(
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const PlayerTimer(),
      
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                  for(int zz = 0; zz < cards.length; zz++)
                    for(int x = 0; x < col; x++)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for(int i = 0; i < row; i++, zz++)
                            (){
                              cardId.putIfAbsent(zz, () => GlobalKey<FlipCardState>());
                              GlobalKey<FlipCardState>? thisCard = cardId[zz];
                              cardState[zz] = true;
                              // bool tempState = cardState[zz];
                                  
                            return CardLoader(cardState: cardState, zz: zz, cards: cards, thisCard: thisCard, col: col, card1: card1, card2: card2);
                            }()
                          ],
                        ),
                      ) 
                    // Text('${cards.length} : $row | $col'),
                    // Text(((MediaQuery.of(context).size.height)).toString()),
                    // Text((MediaQuery.of(context).size.width).toString()),
                    // Text((MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height)).toString()),
                    // Text((MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / row)).toString())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}