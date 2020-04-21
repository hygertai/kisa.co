import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:kisaco/models/url_model.dart';

String apiUrl = "http://10.0.2.2:8080/api"; //TODO 

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

String getQueryString(Map params, {String prefix: '&', bool inRecursion: false}) {
    String query = '';
    params.forEach((key, value) {
        if (inRecursion) {
            key = '[$key]';
        }
        if (value is String || value is int || value is double || value is bool) {
            query += '$prefix$key=$value';
        } else if (value is List || value is Map) {
            if (value is List) value = value.asMap();
            value.forEach((k, v) {
                query += getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
            });
        }
   });
   return query.substring(1);
}

Future<List<dynamic>> sendRequest(String url, Map<String, dynamic> reqBody, String method) async {
  //POST: fixed
  if (method == "POST") {
    String params = getQueryString(reqBody);
    final response = await http.post(apiUrl + url + '?' + params);
    final responseJson = json.decode(response.body);
    return [response.statusCode, responseJson];

  } else if (method == "GET") {
    final response = await http.get(
      apiUrl + url,
      headers: headers,
    );
    updateCookie(response);
    //final responseJson = json.decode(response.body);
    return [response.statusCode];
  } else if (method == "DELETE") {
    final response = await http.delete(
      apiUrl + url,
    );
    updateCookie(response);
    //final responseJson = json.decode(response.body);
    return [response.statusCode];
  } else if (method == "PUT") {
    final response = await http.put(
      apiUrl + url,
    );
    updateCookie(response);
    //final responseJson = json.decode(response.body);
    return [response.statusCode];
  } else {
    return null;
  }
}

Future<List<dynamic>> loginUser(Map<String, dynamic> data) async {
  List<dynamic> response = await sendRequest('/login', data, 'POST');
  Map<String, dynamic> result = response[0]; // Response from API.
  if (response[0] != 200) {
    // Status code from API.
    return [response[0], result['message']]; // Return error message from API.
  } else {
    String message = result['message'];
    int userID = result['data']['user']['id'];
    String email = result['data']['user']['email'];
    String name = result['data']['user']['name'];
    Map<String, dynamic> userDetails = {
      'id': userID,
      'email': email,
      'name': name
    };
    return [response[0], message, userDetails];
  }
}

//signup: fixed
Future<List<dynamic>> signUpUser(Map<String, dynamic> data) async {
  print("working on requests");
  List<dynamic> response = await sendRequest('/users/signup', data, 'POST');
  return [response[0], response[1]]; //status code / user id 
}

Future<List<UrlData>> fillUserLists() async {
  // Get user lists for dashboard view
  var listResponse = await getUserUrls();
  if (listResponse[0] != 200) {
    return [];
  }

  var lists = listResponse[2];

  // Get all items of a user as a hashmap, key: list_id
  var itemResponse = await getUserUrls();
  if (itemResponse[0] != 200) {
    return [];
  }

  var items = itemResponse[2];

  for (var i = 0; i < lists.length; i++) {
    var responseItems =
        items[(lists[i].id).toString()]; // Get respective list items
    List<UrlData> listItems = [];

    // convert dynamic list to Notive ItemModel list
    if (responseItems != null) {
      for (var i = 0; i < responseItems.length; i++) {
        UrlData itemToAdd = UrlData.fromJson(responseItems[i]);
//        String query = itemToAdd.name;
//        itemToAdd.setItemData(query);
        listItems.add(itemToAdd);
      }
    }
    // set items of the list
    lists[i].setItems(listItems);
  }
  return lists;
}

void logoutUser() async {
  await sendRequest('/logout', {}, 'GET');
}

Future<List<dynamic>> createShortLink(Map<String, dynamic> data) async {
  List<dynamic> response = await sendRequest('create', data, 'POST');
  Map<String, dynamic> result = response[1]; //Response from API.
  return [response[0], result['message']]; //Return error message from API.
}

Future<List<dynamic>> createAuthShortLink(Map<String, dynamic> data) async {
  List<dynamic> response = await sendRequest('/create', data, 'POST');
  Map<String, dynamic> result = response[1]; //Response from API.
  return [response[0], result['message']]; //Return error message from API.
}

Future<List<dynamic>> getUserUrls() async {
  List<dynamic> response = await sendRequest('urls/', {}, 'GET');
  Map<String, dynamic> result = response[1];
  print(result);

  if (response[0] != 200) {
    return [response[0], result['message']];
  } else {
    //List<ListModel> lists = [];
    List<dynamic> returnLists = result['data']['urls'];

    for (var i = 0; i < returnLists.length; i++) {
      //lists.add(ListModel.fromJson(returnLists[i]));
    }
    //return [response[0], result['message'], lists];
  }
}

Future<List<dynamic>> getUrlDetails() async {
  List<dynamic> response = await sendRequest('url', {}, 'GET');
  Map<String, dynamic> result = response[1];

  if (response[0] != 200) {
    return [response[0], result['message']];
  } else {
    Map<String, dynamic> returnItems = result['data'];
    return [response[0], result['message'], returnItems];
  }
}

Future<List<dynamic>> deleteUrl(int urlId) async {
  List<dynamic> response = await sendRequest('urls/$urlId', {}, 'DELETE');
  return [response[0], response[1]];
}

Future<List<dynamic>> createNewUrl(Map<String, dynamic> data) async {
  List<dynamic> response = await sendRequest('item', data, 'POST');
  return [response[0], response[1]];
}

void updateCookie(http.Response response) {
  String rawCookie = response.headers['set-cookie'];
  if (rawCookie != null) {
    int index = rawCookie.indexOf(';');
    headers['cookie'] =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
  }
}
