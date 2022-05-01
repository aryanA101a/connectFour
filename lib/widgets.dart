import 'dart:developer';

import 'package:connect_four/coin_model.dart';
import 'package:flutter/material.dart';

import 'connect_four_view_model.dart';

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
