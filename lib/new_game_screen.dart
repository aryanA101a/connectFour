import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/locator.dart';
import 'package:connect_four/socketio_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({Key? key}) : super(key: key);

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
// var connectFourViewModel=

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
