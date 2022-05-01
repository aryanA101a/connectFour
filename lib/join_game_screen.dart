import 'package:connect_four/connect_four_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinGameScreen extends StatelessWidget {
  final Function() handleJoinGame;
  const JoinGameScreen(this.handleJoinGame, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectFourViewModel connectFourViewModel =
        context.watch<ConnectFourViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkResponse(
          onTap: () => Navigator.pop(context),
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
                      handleJoinGame();
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
