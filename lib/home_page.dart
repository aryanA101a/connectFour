import 'dart:async';
import 'dart:developer';

import 'package:connect_four/coin_model.dart';
import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/join_game_screen.dart';
import 'package:connect_four/locator.dart';
import 'package:connect_four/new_game_screen.dart';
import 'package:connect_four/socketio_service.dart';
import 'package:connect_four/temp_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum GameStatus { player1Won, player2Won, draw, goingOn }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  

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
                    onPressed: context.read<ConnectFourViewModel>().newGame,
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
                  onPressed: context.read<ConnectFourViewModel>().joinGame,
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
