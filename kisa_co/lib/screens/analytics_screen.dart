import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisaco/models/user_model.dart';
import 'package:kisaco/screens/authShort_screen.dart';
import 'constants.dart';
import 'dashboard_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kisaco/models/url_model.dart';
import 'package:provider/provider.dart';
import 'package:kisaco/models/request_data.dart';

class AnalyticsScreen extends StatefulWidget {
  static const String id = 'analytics_screen';
  final int urlId;

  AnalyticsScreen({
    this.urlId,
  });

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  UrlData urlData;
  Color color;
  List<String> data = new List();
  Map<String, double> dataMap = new Map();

//  Map<String, double> getDataMapped(List<String> countries) {
//    Map<String, double> dataMap = new Map();
//
//    Future.forEach(countries, (country) {
//      if (!dataMap.containsKey(country)) {
//        dataMap[country] = 1;
//      } else {
//        dataMap[country] += 1;
//      }
//    });
//    print(dataMap);
//    return dataMap;
//  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, user, child) {
        int linksListLength = user.generatedUrl.length;

        if (linksListLength == 0) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Url Analytics'),
            ),
            body: Center(child: Text('You have not generated any URL')),
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
        } else {
          UrlData currentUrl = user.generatedUrl[linksListLength - 1];

          user.getMonthlyDetail(currentUrl);
          user.getCountryInfo(currentUrl);
          List<dynamic> countryInfo = user.countryInfo;
          print("a");
          print(countryInfo);

          //dataMap = getDataMapped(countryInfo);

          String origUrl = currentUrl.orig_url;
          String privacy = currentUrl.is_private.toString();
          String shortUrl = currentUrl.short_url;
          String visitorCount = currentUrl.visitor_count.toString();
          var createdAt = new DateTime.fromMillisecondsSinceEpoch(
              currentUrl.created_at * 1000);
          String createdAtDate = createdAt.toString().substring(0, 16);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Url Analytics'),
            ),
            body: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: kLightPurpleColor,
                    border: Border.all(
                      color: Color(0xff462f3f),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 15.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "URL Info",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
//                          SizedBox(
//                            height: 20,
//                          ),
                            Text(
                              'Private: $privacy',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Shortened URL: " + "kisa.co/" + shortUrl,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Created at: " + createdAtDate,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Total view: $visitorCount",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      //color: kLightPurpleColor,
                      border: Border.all(
                          //color: kOffWhiteColor,
                          ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.all(15.0),
                    child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: CategoryAxis(
                          //labelStyle: ChartTextStyle(color: kOffWhiteColor),
                          axisLine: AxisLine(width: 0),
                          labelPosition: ChartDataLabelPosition.outside,
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
                            format: 'point.x : point.y views',
                            header: ''),
                        series: <ChartSeries<RequestData, String>>[
                          LineSeries<RequestData, String>(
                              dataSource: currentUrl.monthlyClicks,
                              xValueMapper: (RequestData data, _) => data.month,
                              yValueMapper: (RequestData data, _) =>
                                  data.visitorCount,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: false))
                        ]),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Visitors' Info",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(countryInfo.length, (index) {
                      return new ListTile(
                        leading: Text(
                          '$index',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        title: Text(countryInfo[index][1]),
                        trailing: Text(countryInfo[index][0]),
                      );
                    }),
                  ),
                )),
//              Container(
//                height: 250.0,
//                child: SfCircularChart(
//                  palette: <Color>[
//                    Colors.amber,
//                    Colors.brown,
//                    Colors.green,
//                    Colors.redAccent,
//                    Colors.blueAccent,
//                    Colors.teal
//                  ],
//                  title: ChartTitle(text: 'Views per Country'),
//                  legend: Legend(
//                    isVisible: true,
//                    //alignment: ChartAlignment.near,
//                    overflowMode: LegendItemOverflowMode.wrap,
//                    position: LegendPosition.bottom,
//                  ),
//                  series: <CircularSeries<RequestData, dynamic>>[
//                    // Render pie chart
//                    DoughnutSeries<RequestData, String>(
//                      dataLabelSettings: DataLabelSettings(isVisible: true),
//                      dataSource: currentUrl.countryIp,
////                      dataSource: <RequestData>[
////                        RequestData(country: 'TR', visitorCount: 35),
////                        RequestData(country: 'AL', visitorCount: 28),
////                      ],
////                    pointColorMapper: (UrlData data, _) => Colors.white,
//                      xValueMapper: (RequestData data, _) => data.ip,
//                      yValueMapper: (RequestData data, _) => data.visitorCount,
//                      //explode: true,
//                      // First segment will be exploded on initial rendering
//                      //explodeIndex: 1,
//                    ),
//                  ],
//                ),
//              ),
//              Container(
//                child: PieChart(
//                  dataMap: dataMap,
//                ),
//              ),

                SizedBox(
                  height: 25.0,
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
      },
    );
  }
}
