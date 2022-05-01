import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/home_page.dart';
import 'package:connect_four/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String gameLanguage = "ENG";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  setup();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  gameLanguage = prefs.getString('language') ?? "ENG";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<ConnectFourViewModel>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}
