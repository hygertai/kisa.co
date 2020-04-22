import 'dart:collection';
import 'package:flutter/foundation.dart';
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
      print("USER_MODEL login successful");
      var user = response[1];
      print(user);
      this.id = user["id"];
      this.email = user["email"];
      this.name = user["name"];
      isLoggedIn = true;
      notifyListeners();
      return true;
    }
    else {
      print("USER_MODEL login failed");
      print(response[1]);
      return false;
    }
    
  }

  Future<bool> signUp(Map<String, dynamic> data) async {
    var response = await signUpUser(data);
    var status = response[0];

    if (status == 200) {
      print("USER_MODEL: Sign up successful");
      print(response[1]);
      var loginData = new Map<String, dynamic>();
      loginData["email"] = data["email"];
      loginData["password"] = data["password"];
      loginData["name"] = data["name"];
      return login(loginData);
    }
    else{
      print("USER_MODEL: Sign up failed");
      print(response[1]);
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

  Future<String> createAuthLink(Map<String, dynamic> data) async {
    data["user_id"]=this.id;
    print("USER_MODEL: Creating auth short link: ");
    print(data);
    var response = await createAuthShortLink(data);
    var status = response[0];
    if(status == 200){
      Map<String,dynamic> urlData = response[1];
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
        user_id: urlData["userID"]
      );
      _generatedUrl.add(newUrl); //add new url to list 
      return "kisa.co/" + response[1]["shortURL"];
    }
    else{
      print(response[1]);
      return "Error";
    }
  }
}
