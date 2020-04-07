import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:kisaco/components/rounded_button.dart';
//import 'package:kisaco/models/user_model.dart';
import 'package:kisaco/screens/constants.dart';

import 'dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String username;
  String surname;

  Future<void> errorAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'This e-mail is already in use \nor Invalid e-mail adress'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      //backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 40.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: kLightPurpleColor,
              border: Border.all(
                color: Color(0xff462f3f),
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      child: Image(image: AssetImage('images/signup.png')),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kTextFieldDecorationSign.copyWith(
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                            color: Color(0xff462f3f),
                          ),
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: Color(0xff462f3f),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kTextFieldDecorationSign.copyWith(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                            color: Color(0xff462f3f),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff462f3f),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          username = value;
                        },
                        decoration: kTextFieldDecorationSign.copyWith(
                          filled: true,
                          fillColor: kLightPurpleColor,
                          hintText: 'Confirm password',
                          hintStyle: TextStyle(
                            color: Color(0xff462f3f),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff462f3f),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: RoundedButton(
                      title: 'Register',
                      colour: kDarkestPurpleColor,
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });

                        var data = Map<String, dynamic>();
                        data["email"] = email;
                        data["password"] = password;
                        data["name"] = username;
                        data["surname"] = surname;

                        var result = ' ';
//                        await Provider.of<UserModel>(context, listen: false)
//                            .signUp(data);

                        if (result != null) {
                          Navigator.pushNamed(context, DashboardScreen.id);
                        } else {
                          errorAlert(context);
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
