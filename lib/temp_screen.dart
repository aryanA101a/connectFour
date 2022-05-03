import 'package:connect_four/connect_four_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var playerNumber = context.watch<ConnectFourViewModel>().playerNumber;
    return Scaffold(
      body: Center(
          child: Text(
              playerNumber!=null?playerNumber.toString():
                  "Connecting...")),
    );
  }
}
