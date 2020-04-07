import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Shorten Link',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: kLightPurpleColor),
              ),
              SizedBox(),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: kTextFieldDecorationLog.copyWith(
                    hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                child: Text(
                  'Add the Item',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: kLightPurpleColor,
                focusColor: kDarkestPurpleColor,
                onPressed: () {
//                Provider.of<UserModel>(context, listen: false)
//                    .addItem(newItemString);
                  Navigator.pop(context);
                },
              ),
            ],
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
