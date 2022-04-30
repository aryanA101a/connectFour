import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ConnectFourViewModel(),)],
      child: MaterialApp(
        title: 'Flutter Demo',
        
        home:  MyHomePage(),
      ),
    );
  }
}
