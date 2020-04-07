import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisaco/components/rounded_button.dart';
import 'package:kisaco/screens/analytics_screen.dart';
import 'package:kisaco/screens/dashboard_screen.dart';
import 'package:kisaco/screens/welcome_screen.dart';
import 'constants.dart';
import 'package:flutter_beautiful_popup/main.dart';

enum PrivacyChoice { public, private }

class AuthShortScreen extends StatefulWidget {
  static const String id = 'authshort_screen';

  @override
  _AuthShortScreenState createState() => _AuthShortScreenState();
}

class _AuthShortScreenState extends State<AuthShortScreen> {
  PrivacyChoice _choice = PrivacyChoice.private;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KISA.co'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            //color: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: Image(image: AssetImage('images/authShort.png')),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Authenticated Shortening',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25.0, color: kLightPurpleColor),
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
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {},
                      decoration: kTextFieldDecorationLog.copyWith(
                          hintText: 'Define access limit for short link'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Choose link privacy',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20.0, color: kLightPurpleColor),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Public',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: PrivacyChoice.public,
                          activeColor: Colors.amber,
                          groupValue: _choice,
                          onChanged: (PrivacyChoice value) {
                            setState(() {
                              _choice = value;
                            });
                          },
                        ),
                        Text(
                          'Private',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: PrivacyChoice.private,
                          activeColor: Colors.amber,
                          groupValue: _choice,
                          onChanged: (PrivacyChoice value) {
                            setState(() {
                              _choice = value;
                            });
                          },
                        ),
                      ],
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
        ],
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
