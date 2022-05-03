import 'dart:async';
import 'dart:developer';

import 'package:confetti/confetti.dart';
import 'package:connect_four/coin_model.dart';
import 'package:connect_four/home_page.dart';
import 'package:connect_four/join_game_screen.dart';
import 'package:connect_four/locator.dart';
import 'package:connect_four/main.dart';
import 'package:connect_four/new_game_screen.dart';
import 'package:connect_four/socketio_service.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ConnectFourViewModel with ChangeNotifier {
  String _gameCode = "";
  int? _playerNumber;
  String _language = gameLanguage;
  String _appbarTitle =
      gameLanguage == "HIN" ? "चार कनेक्ट करें" : "CONNECT FOUR";
  // late SharedPreferences prefs;

  var _boardData;
  late Status _boardState;
  //constructor
  ConnectFourViewModel() {
    init();
    notifyListeners();
  }
  // loadPrefrences() async {
  //   prefs = await SharedPreferences.getInstance();
  // }

  //initialize/reset every thing
  init() {
    // loadPrefrences();
    _boardData = List.generate(
        6,
        (index) => List.generate(7, (index) {
              return Coin();
            }));
  }

  void changeBoardState() {
    if (_boardState == Status.player1) {
      _boardState = Status.player2;
    } else {
      _boardState = Status.player1;
    }
    notifyListeners();
  }

  game(BuildContext context) {
    // GameStatus winningStatus = checkWinningStatus();
    // if (winningStatus != GameStatus.goingOn) {
    //   showResult(context, winningStatus);
    // }
    // changeBoardState();
    // notifyListeners();
  }

  reset() {
    _boardState = Status.player1;
    _boardData = List.generate(
        6,
        (index) => List.generate(7, (index) {
              return Coin();
            }));
    notifyListeners();
  }

  get boardData => _boardData;
  get boardState => _boardState;

  void showResult(BuildContext context, GameStatus winningStatus) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return WinnerDialog(winningStatus: winningStatus);
        }).then((value) => reset());
  }

  get language => _language;
  changeLanguage(String language) {
    _language = language;
    if (language == "HIN") {
      // prefs.setString("language", "HIN");
      _appbarTitle = "चार कनेक्ट करें";
    } else if (language == "ENG") {
      // prefs.setString("language", "ENG");
      _appbarTitle = "CONNECT FOUR";
    }
    notifyListeners();
  }

  get appbarTitle => _appbarTitle;

  String get gameCode => _gameCode;
  setGameCode(String gameCode) {
    _gameCode = gameCode;
    notifyListeners();
  }

  clearGameCode() {
    _gameCode = "";
  }

  get playerNumber => _playerNumber;
  setPlayerNumber(int playerNumber) {
    _playerNumber = playerNumber;
    notifyListeners();
  }

  joinGame() {
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => JoinGameScreen(),
    ));
  }

  newGame() {
    getIt<SocketIOService>().handleNewGame();
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => NewGameScreen(),
    ));
  }
}

class WinnerDialog extends StatefulWidget {
  final GameStatus winningStatus;
  const WinnerDialog({
    Key? key,
    required this.winningStatus,
  }) : super(key: key);

  @override
  State<WinnerDialog> createState() => _WinnerDialogState();
}

class _WinnerDialogState extends State<WinnerDialog> {
  late ConfettiController _controllerCenter;
  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _controllerCenter,
      blastDirectionality: BlastDirectionality.explosive,
      particleDrag: 0.05,
      emissionFrequency: 0.05,
      numberOfParticles: 50,
      gravity: 0.05,
      shouldLoop: true,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple
      ], // manually specify the colors to be used
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Container(
            // width: 170,
            padding: const EdgeInsets.all(20),
            // height: MediaQuery.of(context).size.width * .8,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset(
                "images/winner.png",
                scale: 6,
              ),
              SizedBox(
                height: 30,
              ),
              widget.winningStatus != GameStatus.draw
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor:
                                widget.winningStatus == GameStatus.player1Won
                                    ? Colors.pink
                                    : Colors.amber,
                            // ts.tambolaNumArr[index].color,
                          ),
                        ),
                        Text(
                          widget.winningStatus == GameStatus.player1Won
                              ? "Player 1 Won"
                              : "Player 2 Won",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    )
                  : const Text(
                      "dRAW",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                  height: MediaQuery.of(context).size.height * .065,
                  onPressed: () {
                    navigatorKey.currentState?.pop();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12)),
                  color: Colors.lightBlue.shade700,
                  child: Text(
                    "Play Again",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ))
            ])),
      ),
    );
  }
}
