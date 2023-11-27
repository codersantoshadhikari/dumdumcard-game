import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dumdumcard/pages/common/bg_pannel.dart';
import 'package:dumdumcard/pages/common/flip_btn.dart';


class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  Map data = {};
  String? username = '';
  int highscore = 0;

  final controllerText = TextEditingController();
  FocusNode textStatus = FocusNode();

  @override
  void dispose() {
    controllerText.dispose();
    super.dispose();
  }

  void saveUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', controllerText.text);
    await prefs.setInt('highscore', highscore);
    
    final String? tempname= prefs.getString('username');
    final int? temphs = prefs.getInt('highscore');
    username = data['username'] = tempname;
    highscore = data['highscore'] = temphs ?? 0;
    debugPrint('Username created: $tempname | $highscore');
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('highscore');
    username = data['username'] = "";
    highscore = data['highscore'] = 0;
    // final String? username= prefs.getString('username');
    debugPrint('Detected: $username | $highscore');
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    Offset loginOffset = data['loginOffset'];
    Offset menuOffset = data['menuOffset'];
    username = data['username'];
    highscore = data['highscore'];
    
    AssetImage scoreboardAccess(){
      if(data['connection'] == true){
        return const AssetImage('assets/images/main_btn/scoreboard.png');
      } else {
        return const AssetImage('assets/images/main_btn/scoreboard-disable.png');
      }
    }
    //=== Welcome Back Message ===

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
            
            //================= Login Pannel =================
            AnimatedSlide(
              offset: loginOffset,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: BgPannel(
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 450,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/labels/title1.png', fit: BoxFit.fitWidth,),
                      Image.asset('assets/images/labels/title2.png', width: 150),
                      
                      const SizedBox(height: 100,),
                            
                      Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                
                            Expanded(
                              child: TextField(
                                controller: controllerText,
                                focusNode: textStatus,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  filled: true,
                                  //enabled: textStatus,
                                  fillColor: Color.fromRGBO(27, 4, 49, 1),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  isDense: true,
                                  label: Text('USERNAME:', style: TextStyle(color: Colors.white70, letterSpacing: 1, fontSize: 12),),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Colors.black)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Colors.white)
                                  ),
                                  
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                autocorrect: false,
                              ),
                            ),
                            
                            const SizedBox(width: 10,),

                            GestureDetector(
                              onTap: (){
                                if(controllerText.text != ''){
                                  setState(() {
                                    textStatus.unfocus();
                                    saveUser();
                                  });
                          
                                  Future.delayed( const Duration(milliseconds: 200), (){
                                    setState(() {
                                      data['loginOffset'] = loginOffset = const Offset(-1.0, 0.0);
                                      data['menuOffset'] = menuOffset = Offset.zero;
                                    });
                                  });
                                } else {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Please 🥺'),
                                        content: const Text('Enter a unique username'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: RotatedBox(quarterTurns: 2, child: Image.asset('assets/images/icon_btn/back.png', fit: BoxFit.fill, height: 50, width: 50,)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            //================= Menu Pannel =================
            AnimatedSlide(
              offset: menuOffset,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: BgPannel(
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 450,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40,),
                      Image.asset('assets/images/labels/title1.png', fit: BoxFit.fitWidth,),
                      Image.asset('assets/images/labels/title2.png', width: 150),
                      
                      const SizedBox(height: 10,),
                      Text('Hello $username'),
                      Text('Best Score: $highscore'),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlipBtn(
                              imageFile: const AssetImage('assets/images/main_btn/play.png'),
                              onFlip: (){
                                Future.delayed( const Duration(milliseconds: 200),(){
                                  startgame(context);
                                  // showDialog<void>(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return AlertDialog(
                                  //       title: const Text('Currently in Development 😉'),
                                  //       content: const Text('Comming Soon...'),
                                  //       actions: <Widget>[
                                  //         TextButton(
                                  //           onPressed: () {
                                  //             Navigator.pop(context);
                                  //           },
                                  //           child: const Text('OK'),
                                  //         ),
                                  //       ],
                                  //     );
                                  //   },
                                  // );
                                });
                              },
                            ),
                            
                            const SizedBox(height: 5,),
                            
                            FlipBtn(
                              imageFile: scoreboardAccess(),
                              onFlip: (){
                                if (data['internetStatus'] == false) {
                                  Future.delayed( const Duration(milliseconds: 200),(){
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('No connection 🥹'),
                                          content: const Text('Restart the app with internet on...'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  });
                                } else {
                                  Future.delayed( const Duration(milliseconds: 200),(){
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Future feature 😱'),
                                          content: const Text('Comming Soon...'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  });
                                  //Navigator.pushNamed(context, './leaderboard');
                                }
                              },
                            ),
                        
                            const SizedBox(height: 5,),
            
                            FlipBtn(
                              imageFile: const AssetImage('assets/images/main_btn/exit.png'),
                              onFlip: (){
                                Future.delayed( const Duration(milliseconds: 200),() {
                                  setState(() {
                                    data['loginOffset'] = loginOffset = Offset.zero;
                                    data['menuOffset'] = menuOffset = const Offset(1.0, 0.0);
                                  });
                                  removeUser();
                                });
                              }
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
  Future<void> startgame(BuildContext context) async{
    final result = await Navigator.pushNamed(context, './game', 
      arguments: {
        'username': username,
        'highscore': highscore
      }
    ) as int;
    if (!mounted) return;
    if((result.runtimeType) == int){
      // print("nice");
      setState(() {
        highscore = data['highscore'] = result;
      });
    }

    // ScaffoldMessenger.of(context)
    // ..removeCurrentSnackBar()
    // ..showSnackBar(SnackBar(content: Text('$result')));
  }
}