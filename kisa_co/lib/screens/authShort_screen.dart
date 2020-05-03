import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kisaco/components/rounded_button.dart';
import 'package:kisaco/screens/analytics_screen.dart';
import 'package:kisaco/screens/dashboard_screen.dart';
import '../models/user_model.dart';
import 'constants.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

enum PrivacyChoice { public, private }

class AuthShortScreen extends StatefulWidget {
  static const String id = 'authshort_screen';

  @override
  _AuthShortScreenState createState() => _AuthShortScreenState();
}

class _AuthShortScreenState extends State<AuthShortScreen> {
  PrivacyChoice _choice = PrivacyChoice.public;
  DateTime selectedDate = DateTime.now();
  bool dateSelected = false;
  PrivacyChoice privChoice = PrivacyChoice.public;

  Future<Null> _selectDate(BuildContext context) async {
    print("Date picker called");
    dateSelected = true;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<DateTime> _getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String origUrl = "";
    String shortUrl = "";
    int visitorLimit = 0;

    final format = DateFormat("yyyy-MM-dd HH:mm");
    DateTime value;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('KISA.co'),
      ),
      //TODO use ListView in case there is need for sth scrollable
      body: Container(
        //color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image(image: AssetImage('images/authShort.png')),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Authenticated Shortening',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0, color: kLightPurpleColor),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Choose link privacy',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: kLightPurpleColor),
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
                            privChoice = value;
                            print(privChoice);
                          });
                        },
                      ),
                      Text(
                        'Private',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Radio(
                        value: PrivacyChoice.private,
                        activeColor: Colors.amber,
                        groupValue: _choice,
                        onChanged: (PrivacyChoice value) {
                          setState(() {
                            _choice = value;
                            privChoice = value;
                            print(privChoice);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.url,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      origUrl = value;
                    },
                    decoration: kTextFieldDecorationLog.copyWith(
                        hintText: 'Enter link here'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value == "") {
                        visitorLimit = 0;
                      } else {
                        visitorLimit = int.parse(value);
                      }
                    },
                    decoration: kTextFieldDecorationLog.copyWith(
                        hintText: 'Enter View Count Limitation'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      shortUrl = value;
                    },
                    decoration: kTextFieldDecorationLog.copyWith(
                        hintText: 'Enter custom name (optional)'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text('Basic date & time field (${format.pattern})'),
                      DateTimeField(
                        decoration: kTextFieldDecorationLog.copyWith(
                            hintText: 'Tap to enter date'),
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            selectedDate = currentValue;
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                    ],
                  ),
//                  RaisedButton(
//                    color: Colors.amber,
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(18.0),
//                        side: BorderSide(color: kDarkestPurpleColor)),
//                    onPressed: () => _selectDate(context),
//                    child: Text(
//                      'Select Expiration date',
//                      style: TextStyle(color: kDarkestPurpleColor),
//                    ),
//                  ),
                  RoundedButton(
                    title: 'Shorten Link',
                    colour: kLightPurpleColor,
                    fontColor: Colors.white,
                    onPressed: () async {
                      Provider.of<UserModel>(context, listen: false)
                          .getAnalytics();
                      var data = Map<String, dynamic>();
                      int privateMode = 0;
                      print(privChoice);
                      if (privChoice == PrivacyChoice.private) {
                        privateMode = 1;
                      }

                      if (dateSelected == false) {
                        data["expires_at"] = 0;
                      } else {
                        data["expires_at"] =
                            (selectedDate.millisecondsSinceEpoch / 1000)
                                .round();
                      }

                      data["orig_url"] = origUrl;
                      print(origUrl);
                      data["short_url"] = shortUrl;
                      data["private_mode"] = privateMode;
                      data["visitor_limit"] = visitorLimit;
                      print(visitorLimit);

                      print(DateTime.now());
                      print(data["expires_at"]);

                      if (privateMode == 1) {
                        data["short_url"] = "";
                      }

                      var result =
                          await Provider.of<UserModel>(context, listen: false)
                              .createAuthLink(data);

                      setState(() {
                        //set state here
                        //errorAlert(context);

                        final popup = BeautifulPopup(
                          context: context,
                          template: TemplateGreenRocket,
                        );

                        popup.show(
                          title: 'Your Short Link',
                          content: result,
                          actions: [
                            popup.button(
                              label: "Copy Short Url",
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: "139.59.155.177:8080/$shortUrl"));
                                // ignore: unnecessary_statements
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AuthShortScreen()),
                                    (Route<dynamic> route) => false);
                              },
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
            title: Text("Profile"),
            icon: Icon(Icons.dashboard),
          ),
        ],
        onTap: (int index) {
          setState(() {
            switch (index) {
              case 0:
                {
                  // Navigate to Dashboard
                  Navigator.pushNamed(context, AuthShortScreen.id);
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
                  Navigator.pushNamed(context, AuthShortScreen.id);
                }
                break;
            }
          });
        },
      ),
    );
  }
}
