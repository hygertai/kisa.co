import 'package:flutter/material.dart';
import 'package:kisaco/components/rounded_button.dart';
import 'package:kisaco/screens/authShort_screen.dart';
import 'package:kisaco/screens/constants.dart';
import 'package:kisaco/screens/login_screen.dart';
import 'package:kisaco/screens/signup_screen.dart';
import 'directShort_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void dispose() {
    if (controller != null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back4.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.60,
                    ),
//                    Row(
//                      children: <Widget>[
//                        Expanded(
//                          child: Container(
//                            child: Image(image: AssetImage('images/logo.png')),
//                          ),
//                        ),
//                        SizedBox(
//                          width: 18.0,
//                        ),
//                      ],
//                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: RoundedButton(
                            title: 'Log In',
                            fontColor: Colors.black87,
                            colour: Colors.deepPurple[200],
                            onPressed: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: RoundedButton(
                            title: 'Sign Up',
                            fontColor: Colors.black87,
                            colour: Colors.deepPurple[200],
                            onPressed: () {
                              Navigator.pushNamed(context, SignupScreen.id);
                            },
                          ),
                        ),
                      ],
                    ),
                    RoundedButton(
                      title: 'Direct URL Shortener',
                      colour: Colors.amberAccent[700],
                      fontColor: kDarkestPurpleColor,
                      onPressed: () {
                        Navigator.pushNamed(context, DirectShortScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
