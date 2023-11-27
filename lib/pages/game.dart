import 'package:dumdumcard/pages/components/board.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

// class cardController extends StatelessElement{
//   final cardId;

//   cardController(super.widget, this.cardId);
//   bool cardIsFlipped = false;

//   void updateCardIsFlipped() => cardIsFlipped = !cardIsFlipped;

//   Future<void> nextQuestion() async {
//     if (cardIsFlipped) {
//       cardId.currentState?.toggleCard();
//     }
//   }  
// }



class _GameState extends State<Game> {

  Map data = {};
  int hs = 0;
  
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    hs = data['highscore'];
    int row = data['row']?? 4;
    int col = data['col']?? 4;

    List cards = [];

    void generateCard(){
      int totalPair = ((row*col)/2).round();
      int temp;
      for(int x = 0; x < totalPair; x++){
        while(true){
          temp = (Random().nextInt(25) +1);
          if(!cards.contains(temp)) break;
        }
        cards.add(temp);
        cards.add(temp);

      }
      cards.shuffle();
    }

    generateCard();

    

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/bg.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          )
        ),
        child: Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.antiAlias,
          children: [
            
            Board(data: data, cards: cards, row: row, column: col),

            Container(
                  padding: const EdgeInsets.only(top:60, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // ElevatedButton(
                      //   onPressed: (){
                      //     // PlayerTimer(startTime());
                      //   },
                      //   child: const Text('Start timer'),
                      // ),
                      IconButton(
                        icon: Image.asset(
                          'assets/images/icon_btn/reset.png',
                          fit: BoxFit.fill,
                        ),
                        padding: EdgeInsets.zero,
                        iconSize: 50,
                        onPressed: () {
                          setState(() {
                            generateCard();
                          });
                        },
                      ),
                
                      const SizedBox(width: 10,),
                
                      IconButton(
                        icon: Image.asset(
                          'assets/images/icon_btn/close.png',
                          fit: BoxFit.fill,
                        ),
                        padding: EdgeInsets.zero,
                        iconSize: 50,
                        onPressed: () {
                          Navigator.pop(context, hs);
                        },
                      )
                    ]
                  ),
                ),

            // ElevatedButton(
            //   onPressed: (){
            //     setState(() {
            //       // hs = data['highscore']+=2;
            //       //hs = Random().nextInt(3);
            //       generateCard();
            //       //print(hs+1);
            //     });
            //   },
            //   child: const Text("Reset"),
            // ),
          ],
        ),
      ),
    );
  }
}