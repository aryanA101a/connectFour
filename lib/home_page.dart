import 'dart:async';
import 'dart:developer';

import 'package:connect_four/coin_model.dart';
import 'package:connect_four/connect_four_view_model.dart';

import 'package:flutter/material.dart';
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
    var connectFourViewModel = context.watch<ConnectFourViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(
          connectFourViewModel.appbarTitle,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
            // color: base_purple,

            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Center(
                child: Text(
                  connectFourViewModel.language,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(0),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) {
              switch (value) {
                case "HIN":
                  {
                    connectFourViewModel.changeLanguage("HIN");
                    
                  }
                  break;
                case "ENG":
                  {
                    connectFourViewModel.changeLanguage("ENG");
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  value: "ENG",
                  child: Row(
                    children: [
                      Text("ENG",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  )),
              PopupMenuItem(
                child: Divider(color: Colors.grey),
                height: 0,
              ),
              PopupMenuItem(
                  value: "HIN",
                  child: Row(
                    children: [
                      Text("HIN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  )),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Board(connectFourViewModel: connectFourViewModel),
            MaterialButton(
              height: 50,
              elevation: 0,
              color: Colors.lightBlue,
              shape: CircleBorder(),
              onPressed: () {
                connectFourViewModel.reset();
              },
              child: Icon(
                Icons.replay,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Board extends StatelessWidget {
  const Board({
    Key? key,
    required this.connectFourViewModel,
  }) : super(key: key);

  final ConnectFourViewModel connectFourViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        color: Colors.lightBlue.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  6,
                  (r) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            7,
                            (c) => CoinWidget(
                                  context,
                                  coin: connectFourViewModel.boardData[r][c],
                                  state: connectFourViewModel.boardState,
                                  gameCallback: connectFourViewModel.game,
                                )),
                      )),
            )),
      ),
    );
  }
}

class CoinWidget extends StatefulWidget {
  BuildContext ctx;
  Coin coin;
  Status state;
  Function gameCallback;
  CoinWidget(this.ctx,
      {required this.coin,
      required this.state,
      required this.gameCallback,
      Key? key})
      : super(key: key);

  @override
  State<CoinWidget> createState() => _CoinWidgetState();
}

class _CoinWidgetState extends State<CoinWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: InkResponse(
        onTap: widget.coin.state == Status.empty
            ? () {
                log(widget.state.name);
                widget.coin.changeState(widget.state);
                widget.gameCallback(widget.ctx);
              }
            : null,
        child: CircleAvatar(
          radius: 18,
          backgroundColor: widget.coin.color,
          // ts.tambolaNumArr[index].color,
        ),
      ),
    );
  }
}
