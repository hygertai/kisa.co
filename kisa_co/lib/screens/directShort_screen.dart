import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisaco/components/rounded_button.dart';
import 'package:kisaco/screens/analytics_screen.dart';
import 'package:kisaco/screens/dashboard_screen.dart';
import 'package:kisaco/screens/welcome_screen.dart';
import 'constants.dart';
import 'package:flutter_beautiful_popup/main.dart';

class DirectShortScreen extends StatefulWidget {
  static const String id = 'directshort_screen';

  @override
  _DirectShortScreenState createState() => _DirectShortScreenState();
}

class _DirectShortScreenState extends State<DirectShortScreen> {
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
                Text('Incorrect Username or Password'),
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
      appBar: AppBar(
        title: Text('KISA.co'),
      ),
      body: Container(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Container(
                    child: Image(image: AssetImage('images/shorten.png')),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Direct Shortening',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, color: kLightPurpleColor),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {},
                  decoration: kTextFieldDecorationLog.copyWith(
                      hintText: 'Enter link here'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RoundedButton(
                  title: 'Shorten Link',
                  colour: kLightPurpleColor,
                  onPressed: () async {
                    setState(() {
                      //set state here
                      //errorAlert(context);

                      final popup = BeautifulPopup(
                        context: context,
                        template: TemplateGreenRocket,
                      );

                      popup.show(
                        title: 'Your Short Link',
                        content: 'Shortened Link Here.',
                        actions: [
                          popup.button(
                            label: 'Copy Link',
                            onPressed: Navigator.of(context).pop,
                          ),
                        ],
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        fixedColor: kLightPurpleColor,
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Analytics"),
            icon: Icon(Icons.show_chart),
          ),
          BottomNavigationBarItem(
            title: Text("Dashboard"),
            icon: Icon(Icons.dashboard),
          ),
        ],
        onTap: (int index) {
          setState(() {
            switch (index) {
              case 0:
                {
                  // Navigate to Dashboard
                  Navigator.pushNamed(context, WelcomeScreen.id);
                }
                break;
              case 1:
                {
                  // Navigate to Archived List
                  Navigator.pushNamed(context, AnalyticsScreen.id);
                }
                break;
              case 2:
                {
                  // Map
                  Navigator.pushNamed(context, DashboardScreen.id);
                }
                break;
              default:
                {
                  Navigator.pushNamed(context, WelcomeScreen.id);
                }
                break;
            }
          });
        },
      ),
    );
  }
}
