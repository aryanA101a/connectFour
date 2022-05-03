import 'dart:developer';

import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/constants.dart';
import 'package:connect_four/locator.dart';
import 'package:connect_four/main.dart';
import 'package:connect_four/temp_screen.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOService {
  late IO.Socket socket;

  SocketIOService() {
    initSocket();
  }
  reconnect() {
    socket.disconnected ? socket.connect() : null;
  }

  handleJoinGame() {
    String code = getIt<ConnectFourViewModel>().gameCode;
    socket.emit('joinGame', code);
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => TempScreen(),
    ));
    print(getIt<ConnectFourViewModel>().gameCode);
  }

  handleNewGame() {
    socket.emit('newGame');
  }

  handleGameCode(gameCode) {
    getIt<ConnectFourViewModel>().setGameCode(gameCode);
  }

  handlePlayerNumber(playerNumber) {
    print("*********$playerNumber");
    getIt<ConnectFourViewModel>().setPlayerNumber(playerNumber);
  }

  handleStartGame(payload) {
    if (getIt<ConnectFourViewModel>().playerNumber == 1) {
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => TempScreen(),
      ));
    }
  }

  initSocket() {
    try {
      socket = IO.io(
          serverUrl,
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              // .enableAutoConnect()
              .build() // disable auto-connection

          );
      socket.connect();

      socket.on('gameCode', handleGameCode);
      socket.on('playerNumber', handlePlayerNumber);
      socket.on('startGame', handleStartGame);
    } catch (e) {
      log(e.toString());
    }
  }

  void disconnect() {
    // socket.disconnect();
    getIt<ConnectFourViewModel>().clearGameCode();
    socket.disconnect();
  }
}
