import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisaco/models/user_model.dart';
import 'package:kisaco/screens/welcome_screen.dart';
import 'constants.dart';
import 'dashboard_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kisaco/models/url_model.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatefulWidget {
  static const String id = 'analytics_screen';

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(builder: (context, user, child) {
      var currentUrl = user.generatedUrl[0];
      String origUrl = currentUrl.orig_url;
      String shortUrl= currentUrl.short_url;
      String visitorCount = currentUrl.visitor_count.toString();
      var createdAt = new DateTime.fromMillisecondsSinceEpoch(currentUrl.created_at * 1000);
      String createdAtDate = createdAt.toString().substring(0,16);
      return Scaffold(
        appBar: AppBar(
          title: Text('Url Analytics'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Original URL: " + origUrl,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Shortened URL: "+ "kisa.co/" + shortUrl,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Created at: "+ createdAtDate,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Total view: "+ visitorCount,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  //color: kLightPurpleColor,
                  border: Border.all(
                      //color: kOffWhiteColor,
                      ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.all(20.0),
                child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      //labelStyle: ChartTextStyle(color: kOffWhiteColor),
                      axisLine: AxisLine(width: 0),
                      labelPosition: ChartDataLabelPosition.inside,
                      majorTickLines: MajorTickLines(width: 0),
                      majorGridLines: MajorGridLines(width: 0),
                    ),
//                primaryYAxis:
//                    NumericAxis(isVisible: false, minimum: 0, maximum: 9000),
                    // Chart title
                    title: ChartTitle(text: 'All time views'),
                    // Enable legend
                    //legend: Legend(isVisible: true),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(
                        enable: true,
                        canShowMarker: false,
                        format: 'point.x : point.y sq.km',
                        header: ''),
                    series: <ChartSeries<UrlData, String>>[
                      LineSeries<UrlData, String>(
                          // dataSource: <UrlData>[
                          //   UrlData(url_id: 1, month: 'Jan', visitor_count: 35),
                          //   UrlData(url_id: 1, month: 'Feb', visitor_count: 28),
                          //   UrlData(url_id: 1, month: 'Mar', visitor_count: 34),
                          //   UrlData(url_id: 1, month: 'Apr', visitor_count: 32),
                          //   UrlData(url_id: 1, month: 'May', visitor_count: 40)
                          // ],
                          // xValueMapper: (UrlData sales, _) => sales.month,
                          // yValueMapper: (UrlData sales, _) => sales.visitor_count,
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            Container(),
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
    });
  }
}
