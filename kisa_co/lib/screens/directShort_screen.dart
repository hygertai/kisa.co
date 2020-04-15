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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KISA.co'),
      ),
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
    );
  }
}
