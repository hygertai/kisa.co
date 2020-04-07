import 'package:flutter/material.dart';
import 'package:kisaco/screens/welcome_screen.dart';
import 'package:kisaco/screens/constants.dart';
import 'package:kisaco/screens/dashboard_screen.dart';
import 'package:kisaco/screens/login_screen.dart';
import 'package:kisaco/screens/signup_screen.dart';
import 'package:kisaco/screens/directShort_screen.dart';

//import 'package:http/http.dart' as http;

void main() {
  runApp(KisaCo()
//    MultiProvider(
//      providers: [
//        ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
////        ChangeNotifierProvider<ListModel>(create: (context) => ListModel()),
//        //Provider(create: (context) => Dashboard()),
//      ],
//      child: NotiveApp(),
//    ),
      );
}

class KisaCo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    var log = Provider.of<UserModel>(context, listen: false).isLoggedIn;

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kOffWhiteColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // additional settings go here
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        DashboardScreen.id: (context) => DashboardScreen(),
        DirectShortScreen.id: (context) => DirectShortScreen(),
      },
    );
  }
}
