import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:kisaco/models/request_data.dart';
import 'package:kisaco/models/url_model.dart';
import 'package:kisaco/util/requests.dart';

import '../util/requests.dart';
import 'url_model.dart';
import 'url_model.dart';

class UserModel extends ChangeNotifier {
  int id;
  String email;
  String name;

  List<UrlData> _generatedUrl = [];
  bool isLoggedIn = false;
  List<dynamic> countryInfo = [];

  UserModel({this.id, this.email, this.name});

  UnmodifiableListView<UrlData> get generatedUrl {
    return UnmodifiableListView(_generatedUrl);
  }

//  List<UrlData> getUrls() {
//    if (this.urls.length == 0) {
//      return null;
//    }
//    List<UrlData> urls = this.urls[this.id].urls;
//    if (urls != null) {
//      for (int i = 0; i < urls.length; i++) {
//          urls.add(i);
//        }
//      }
//    }
//    return urls;
//  }

  Future<bool> login(Map<String, dynamic> data) async {
    var response = await loginUser(data);
    var status = response[0];
    if (status == 200) {
      var user = response[1];
      this.id = user["id"];
      this.email = user["email"];
      this.name = user["name"];
      isLoggedIn = true;
      notifyListeners();
      getAnalytics();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(Map<String, dynamic> data) async {
    var response = await signUpUser(data);
    var status = response[0];

    if (status == 200) {
      var loginData = new Map<String, dynamic>();
      loginData["email"] = data["email"];
      loginData["password"] = data["password"];
      loginData["name"] = data["name"];
      return login(loginData);
    } else {
      return false;
    }
  }

  void logout() {
    logoutUser();
    isLoggedIn = false;
    notifyListeners();
  }

  UnmodifiableListView<UrlData> get urlList {
    return UnmodifiableListView(_generatedUrl);
  }

  int get userUrlsCount {
    return _generatedUrl.length;
  }

void getCountryInfo(UrlData url) async {
  print("getCountryInfo called");
  var response = await getURLVisitorInfo(url.url_id);
  if(response[0] == 200){
    countryInfo = response[1];
    print(response[1]);
  }
  else{
    print(response[1]);
  }
}

void getMonthlyDetail(UrlData url) async{
    var response = await getURLMonthDetails(url.url_id);
    if(response[0] == 200)
    {
      List<dynamic> urlMonthly = response[1]["months"];
      url.addData(RequestData("Jan", urlMonthly[0]));
      url.addData(RequestData("Feb", urlMonthly[1]));
      url.addData(RequestData("March", urlMonthly[2]));
      url.addData(RequestData("Apr", urlMonthly[3]));
      url.addData(RequestData("May", urlMonthly[4]));
      // url.addData(MonthlyData("June", urlMonthly[5]));
      // url.addData(MonthlyData("July", urlMonthly[6]));
      // url.addData(MonthlyData("Aug", urlMonthly[7]));
      // url.addData(MonthlyData("Sep", urlMonthly[8]));
      // url.addData(MonthlyData("Oct", urlMonthly[9]));
      // url.addData(MonthlyData("Nov", urlMonthly[10]));
      // url.addData(MonthlyData("Dec", urlMonthly[11]));
      
      print(response[1]);
    }
    else{
      print(response[1]);
    }
  }

  Future<bool> getAnalytics() async {
    print("get analytics called");
    var response = await getUserAnalytics(id);

    if (response[0] == 200) {
      List<dynamic> userData = response[1];
      for (int i = 0; i < userData.length; i++) {
        var analytic = userData[i]; // Map string dynamic
        var urlData = analytic["url"]; // Url objesi(MAP)
        var requests = analytic["requests"]; //List of maps

        //Fill user url list
        UrlData newUrl = new UrlData(
            visitor_count: urlData["visitorCount"],
            is_private: urlData["private"],
            visitor_limit: urlData["visitorLimit"],
            creator_ip: urlData["creatorIP"],
            expires_at: urlData["expiresAt"],
            created_at: urlData["createdAt"],
            short_url: urlData["shortURL"],
            orig_url: urlData["origURL"],
            url_id: urlData["id"],
            user_id: urlData["userID"]);

        newUrl.requests = requests;
        _generatedUrl.add(newUrl);
        getMonthlyDetail(_generatedUrl[i]);
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fillUrlRequest() async {
    var response = await getUserAnalytics(id);

    if (response[0] == 200) {
      List<dynamic> userData = response[1];
      for (int i = 0; i < userData.length; i++) {
        var analytic = userData[i]; // Map string dynamic
        //var urlData = analytic["url"]; // Url objesi(MAP)
        var requests = analytic["requests"]; //List of maps

        _generatedUrl[i].requests = requests;
      }
      return true;
    } else {
      return false;
    }
  }

  Future<String> createDirectShortLink(Map<String, dynamic> data) async {
    var response = await createShortLink(data);
    var status = response[0];
    if (status == 200) {
      return "kisa.co/" + response[1]["shortURL"];
    } else {
      return "Error";
    }
  }

  Future<String> createAuthLink(Map<String, dynamic> data) async {
    data["user_id"] = this.id;
    var response = await createAuthShortLink(data);
    var status = response[0];
    print(response[1]);
    if (status == 200) {
      Map<String, dynamic> urlData = response[1];
      UrlData newUrl = new UrlData(
          visitor_count: urlData["visitorCount"],
          is_private: urlData["private"],
          visitor_limit: urlData["visitorLimit"],
          creator_ip: urlData["creatorIP"],
          expires_at: urlData["expiresAt"],
          created_at: urlData["createdAt"],
          short_url: urlData["shortURL"],
          orig_url: urlData["origURL"],
          url_id: urlData["id"],
          user_id: urlData["userID"]);
      _generatedUrl.add(newUrl); //add new url to list
      return "kisa.co/" + response[1]["shortURL"];
    } else {
      return "Error";
    }
  }
}
