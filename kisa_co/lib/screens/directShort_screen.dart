import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisaco/components/rounded_button.dart';
import 'constants.dart';

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
            title: Text("Search"),
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            title: Text("Add"),
            icon: Icon(Icons.add_box),
          ),
        ],
        onTap: (int index) {
          setState(() {
            //_currentIndex = index;
          });
        },
      ),
    );
  }
}
