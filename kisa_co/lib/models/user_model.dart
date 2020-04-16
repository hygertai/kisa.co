import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:kisaco/models/url_model.dart';
import 'package:kisaco/util/requests.dart';

class UserModel extends ChangeNotifier {
  int id;
  String email;
  String name;

  int userMapIndex = 0;
  List<UrlData> _generatedUrl = [];
  bool isLoggedIn = false;

  UserModel({this.id, this.email, this.name});

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
      var user = response[2];
      this.id = user["user_id"];
      this.email = user["email"];
      this.name = user["name"];

      isLoggedIn = true;
      response = await fillUserLists();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signUp(Map<String, dynamic> data) async {
    var response = await signUpUser(data);
    var status = response;

    if (status == 200) {
      var loginData = new Map<String, dynamic>();
      loginData["email"] = data["email"];
      loginData["password"] = data["password"];
      loginData["username"] = data["username"];
      return login(loginData);
    }
    return false;
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

//  void addItem(String itemName) async {
//    Map<String, dynamic> data = {
//      'name': itemName,
//      'list_id': this._generatedUrl[this.curListIndex].url_id
//    };
//
//    List<dynamic> result = await createNewUrl(data);
//
//    if (result[0] == 200) {
//      UrlData item = new UrlData(month, visitor_count);
//      this._generatedUrl[curListIndex].addN(item);
//      notifyListeners();
//    }
//    //TODO add warning message in case of failure
//  }
//
//  void deleteItem(ItemModel item) async {
//    List<dynamic> result = await deleteUserItem(item.listId, item.id);
//
//    if (result[0] == 200) {
//      this._generatedUrl[curListIndex].deleteItem(item);
//      notifyListeners();
//    }
//    //TODO add warning message in case of failure
//  }
//
//  void changeItemName(ItemModel item, String newName) async {
//    Map<String, dynamic> data = {"name": newName};
//    List<dynamic> result = await updateUserItem(data, item);
//    if (result[0] == 200) {
//      item.setName(newName);
//      notifyListeners();
//    }
//  }
//
//  //just being used after login, therefore there is no need for notifying listeners
//  void setLists(List<ListModel> lists) {
//    for (int i = 0; i < lists.length; i++) {
//      if (lists[i].isArchived == false) {
//        _generatedUrl.add(lists[i]);
//      } else {
//        _archivedLists.add(lists[i]);
//      }
//    }
//  }

}
