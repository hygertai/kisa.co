import 'package:flutter/material.dart';
import 'package:kisaco/screens/authShort_screen.dart';
import 'package:kisaco/screens/welcome_screen.dart';
import 'package:kisaco/screens/constants.dart';
import 'package:kisaco/screens/dashboard_screen.dart';
import 'package:kisaco/screens/login_screen.dart';
import 'package:kisaco/screens/signup_screen.dart';
import 'package:kisaco/screens/directShort_screen.dart';
import 'package:kisaco/screens/analytics_screen.dart';
import 'package:provider/provider.dart';
import 'models/user_model.dart';

//import 'package:http/http.dart' as http;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
      ],
      child: KisaCo(),
    ),
  );
}

class KisaCo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        AnalyticsScreen.id: (context) => AnalyticsScreen(),
        AuthShortScreen.id: (context) => AuthShortScreen(),
      },
    );
  }
}
