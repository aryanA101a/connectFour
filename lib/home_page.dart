import 'dart:async';
import 'dart:developer';

import 'package:connect_four/coin_model.dart';
import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/join_game_screen.dart';
import 'package:connect_four/new_game_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum GameStatus { player1Won, player2Won, draw, goingOn }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late IO.Socket socket;
  joinGame() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinGameScreen(handleJoinGame),
        ));
  }

  newGame() {
    handleNewGame();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewGameScreen(),
        ));
  }

  handleJoinGame() {
    String code = context.read<ConnectFourViewModel>().gameCode;
    socket.emit('joinGame',code);

  }

  handleNewGame() {
    socket.emit('newGame');
  }

  handleGameCode(gameCode) {
    context.read<ConnectFourViewModel>().setGameCode(gameCode);
  }

  handlePlayerNumber(playerNumber) {
    context.read<ConnectFourViewModel>().setPlayerNumber(playerNumber);
  }

  initSocket() {
    try {
      socket = IO.io(
          'https://6e0b-2409-4043-2e02-3eeb-6ce4-d53e-2857-7f7c.in.ngrok.io',
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .enableAutoConnect()
              .build() // disable auto-connection

          );
      socket.on('gameCode', handleGameCode);
      socket.on('playerNumber', handlePlayerNumber);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    initSocket();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          RichText(
            text: TextSpan(
              text: 'C',
              style: GoogleFonts.poppins(
                color: Colors.lightBlue.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
              children: [
                TextSpan(
                    text: 'o',
                    style: TextStyle(
                      color: Colors.amber.shade700,
                    )),
                TextSpan(text: 'nnect'),
                TextSpan(text: ' F'),
                TextSpan(
                    text: 'o',
                    style: TextStyle(
                      color: Colors.pink.shade500,
                    )),
                TextSpan(text: 'ur'),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: MaterialButton(
                    color: Colors.lightBlue.shade200,
                    elevation: 0,
                    onPressed: newGame,
                    child: Text(
                      "NEW GAME",
                      style: GoogleFonts.raleway(
                        color: Colors.lightBlue.shade700,
                        fontSize: 32,
                      ),
                    )),
              ),
              MaterialButton(
                  color: Colors.lightBlue.shade200,
                  elevation: 0,
                  onPressed: joinGame,
                  child: Text(
                    "JOIN GAME",
                    style: GoogleFonts.raleway(
                      color: Colors.lightBlue.shade700,
                      fontSize: 32,
                    ),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
