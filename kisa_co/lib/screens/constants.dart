import 'package:flutter/material.dart';

//from input_page.dart
const double kBottomContainerHeight = 80;
const Color kDarkestPurpleColor = Color(0xFF1F0719);
const Color kPurpleColor = Color(0xFF4D51D0);
const Color kLightPurpleColor = Color(0xFFAAAACD);
const Color kBrownColor = Color(0xFF592942);
const Color kOffWhiteColor = Color(0xFFF6F3F9);
const Color kLightPinkColor = Color(0xFFFD9297);
const Color kMediumPinkColor = Color(0xFFEA7A86);

//from icon_content.dart
const double iconSize = 70.0;
const double fontSize = 18.0;
const Color fontColor = Color(0xFF8D8E98);
const double textIconSpace = 15.0;

// STYLES
const kMyTextStyle = TextStyle(
  fontSize: fontSize,
  color: fontColor,
);

const kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kTitleStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
);

const kStatusStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: Colors.green,
);

const kResultStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.w900,
);

const kAnotherTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.w500,
);

const double minScale = 120.0;
const double maxScale = 220.0;

const kSendButtonTextStyle = TextStyle(
  color: Colors.orangeAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.orangeAccent, width: 2.0),
  ),
);

const kTextFieldDecorationLog = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLightPurpleColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLightPurpleColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kTextFieldDecorationSign = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPurpleColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPurpleColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
