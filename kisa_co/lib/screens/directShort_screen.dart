import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisaco/components/rounded_button.dart';
import 'package:kisaco/models/user_model.dart';
import 'package:kisaco/screens/welcome_screen.dart';
import 'constants.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:provider/provider.dart';

class DirectShortScreen extends StatefulWidget {
  static const String id = 'directshort_screen';

  @override
  _DirectShortScreenState createState() => _DirectShortScreenState();
}

class _DirectShortScreenState extends State<DirectShortScreen> {
  String shortUrl = "Suppose this is the generated URL";

  @override
  Widget build(BuildContext context) {
    String origUrl;
    String shortUrl;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.black,
        title: IconButton(
          icon: Image.asset('images/logo.png'),
          onPressed: () {
            Navigator.pushNamed(context, WelcomeScreen.id);
          },
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert),
              )),
        ],
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Image(image: AssetImage('images/shorten.png')),
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
                    onChanged: (value) {
                      origUrl = value;
                    },
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
                      var data = Map<String,dynamic>();
                      data["user_id"]=0;
                      data["orig_url"]=origUrl;
                      data["short_url"]="";
                      data["expires_at"]=0;
                      data["private_mode"]=0;
                      data["visitor_limit"]=0;
                      var result = await Provider.of<UserModel>(context, listen: false)
                                    .createDirectShortLink(data);
                      
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
                                Clipboard.setData(
                                    ClipboardData(text: shortUrl));
                                // ignore: unnecessary_statements
                                Navigator.of(context).pop;
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
    );
  }
}
