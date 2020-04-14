import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisaco/screens/welcome_screen.dart';
import 'constants.dart';
import 'dashboard_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kisaco/models/url_model.dart';

class AnalyticsScreen extends StatefulWidget {
  static const String id = 'analytics_screen';

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Url Analytics'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              //height: 100.0,
              decoration: BoxDecoration(
                color: kDarkestPurpleColor,
                border: Border.all(
                  color: kDarkestPurpleColor,
                ),
                //borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Generation Date',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text('Link Name '),
                    leading: Icon(
                      Icons.insert_link,
                      color: kLightPurpleColor,
                    ),
                  ),
                  ListTile(
                    title: Text('Customized URL',
                        style: TextStyle(fontWeight: FontWeight.w200)),
                    subtitle: Text('Short Random URL'),
                  ),
                ],
              ),
            ),
          ),
          Container(
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
                      dataSource: <UrlData>[
                        UrlData('Jan', 35),
                        UrlData('Feb', 28),
                        UrlData('Mar', 34),
                        UrlData('Apr', 32),
                        UrlData('May', 40)
                      ],
                      xValueMapper: (UrlData sales, _) => sales.month,
                      yValueMapper: (UrlData sales, _) => sales.visitor_count,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
//                    decoration: BoxDecoration(
//                      color: kLightPurpleColor,
//                      border: Border.all(
//                          color: kOffWhiteColor,
//                          ),
//                      borderRadius: BorderRadius.circular(20.0),
//                    ),
                    margin: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Info 1'),
                          leading: Icon(
                            Icons.crop_square,
                            color: Colors.blue[500],
                          ),
                        ),
                        ListTile(
                          title: Text('Info 2'),
                          leading: Icon(
                            Icons.blur_circular,
                            color: Colors.blue[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
//                    decoration: BoxDecoration(
//                      color: kLightPurpleColor,
//                      border: Border.all(
//                          color: kOffWhiteColor,
//                          ),
//                      borderRadius: BorderRadius.circular(20.0),
//                    ),
                    margin: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Info 1'),
                          leading: Icon(
                            Icons.crop_square,
                            color: Colors.blue[500],
                          ),
                        ),
                        ListTile(
                          title: Text('Info 2'),
                          leading: Icon(
                            Icons.blur_circular,
                            color: Colors.blue[500],
                          ),
                        ),
                      ],
                    ),
                  ),
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
