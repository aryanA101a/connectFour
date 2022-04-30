import 'package:flutter/material.dart';

enum Status { empty, player1, player2 }

class Coin {
  Status state = Status.empty;
  Color color = Colors.white;

  changeState(Status state) {
    this.state = state;
    if (this.state == Status.player1) {
      color = Colors.pink;
    }else if (this.state == Status.player2) {
      color = Colors.amber;
    }
  }
}
