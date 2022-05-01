import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({Key? key}) : super(key: key);
// var connectFourViewModel=
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            child: Text("waiting for player to connect...",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  color: Colors.black,
                )),
          ),
          SelectableText.rich(
            TextSpan(
              text: 'Game Code: ',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
              children: [
                TextSpan(
                    text: context.watch<ConnectFourViewModel>().gameCode,
                    style: TextStyle(
                      color: Colors.lightBlue.shade700,
                    )),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
