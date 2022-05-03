import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/main.dart';
import 'package:connect_four/socketio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

class JoinGameScreen extends StatefulWidget {
  // final Function() handleJoinGame;
  const JoinGameScreen( {Key? key}) : super(key: key);

  @override
  State<JoinGameScreen> createState() => _JoinGameScreenState();
}

class _JoinGameScreenState extends State<JoinGameScreen> {
  

   @override
  void initState() {
    getIt<SocketIOService>().reconnect();
    super.initState();
  }

  @override
  void dispose() {
    getIt<SocketIOService>().disconnect();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    ConnectFourViewModel connectFourViewModel =
        context.watch<ConnectFourViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkResponse(
          onTap: () => navigatorKey.currentState?.pop(),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Join Game",
          style: TextStyle(color: Colors.black),
        ),
        // centerTitle: true,
        actions: [
          TextButton(
              onPressed: connectFourViewModel.gameCode.isNotEmpty
                  ? () {
                      getIt<SocketIOService>().handleJoinGame();
                    }
                  : null,
              child: Text("Start"))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
            child: const Text("Enter a game code"),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  alignLabelWithHint: false,
                  contentPadding: EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Game Code',
                  hintStyle: TextStyle(fontSize: 18),
                  // errorText: errorSnapshot.data == 0
                  //     ? Localization.of(context).categoryEmpty
                  //     : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                onChanged: (val) {
                  connectFourViewModel.setGameCode(val);
                },
              ))
        ],
      ),
    );
  }
}
