import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kisaco/models/url_model.dart';
import 'package:kisaco/screens/authShort_screen.dart';
import 'analytics_screen.dart';
import 'constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = 'dashboard_screen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //an instance of the URL model comes here
  final List<UrlData> _data = [
    UrlData(
      created_at: '30/03/2020',
      orig_url: 'https://flutter.dev/docs/development/ui/widgets/text',
      short_url: 'https://kisa.co/12Xc3S3',
    ),
    UrlData(
      created_at: '20/02/2020',
      orig_url: 'https://flutter.dev/docs/development/ui/widgets/text',
      short_url: 'https://kisa.co/12Xc3S3',
    ),
    UrlData(
      created_at: '10/02/2020',
      orig_url: 'https://flutter.dev/docs/development/ui/widgets/text',
      short_url: 'https://kisa.co/12Xc3S3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'User Profile',
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 330,
                  color: kDarkestPurpleColor,
                ),
                Column(
                  children: <Widget>[
                    Container(
                        height: 90,
                        margin: EdgeInsets.only(top: 60),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Image(image: AssetImage('images/logo.png')),
                        )),
                    Padding(
                      padding: EdgeInsets.all(4),
                    ),
                    Text(
                      "Hygerta Imeri",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                    ),
                    Text(
                      "user@gmail.com",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 77),
                      padding: EdgeInsets.all(10),
                      child: Card(
                        color: kLightPurpleColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 5),
                                    child: Text("Active URLs",
                                        style:
                                            TextStyle(color: Colors.black87))),
                                Container(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Text("15",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16))),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 5),
                                    child: Text("Dead URLs",
                                        style:
                                            TextStyle(color: Colors.black87))),
                                Container(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Text("2",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16))),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 5),
                                    child: Text("Total Views",
                                        style:
                                            TextStyle(color: Colors.black87))),
                                Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text("389",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //UserInfo()
                  ],
                )
              ],
            ),
            Container(
              //height: _allArea.length > 3 ? 150.0 : _allArea.length * 50.0,
              margin: EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                color: kOffWhiteColor,
                border: Border.all(
                  color: kBrownColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: new ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(6),
                itemCount: _data.length,
                itemBuilder: (BuildContext context, int index) {
                  UrlData item = _data[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.created_at,
                          style: TextStyle(
                            color: kDarkestPurpleColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          item.orig_url,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Linkify(
                          onOpen: (link) async {
                            if (await canLaunch(link.url)) {
                              await launch(link.url);
                            } else {
                              throw 'Could not launch';
                            }
                          },
                          text: item.short_url,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
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
