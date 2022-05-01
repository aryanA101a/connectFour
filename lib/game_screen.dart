import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/home_page.dart';
import 'package:connect_four/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({ Key? key }) : super(key: key);

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
                connectFourViewModel.showResult(context, GameStatus.player1Won);
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