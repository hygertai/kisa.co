class UrlData {
  UrlData({this.month, this.visitor_count});

  final String month;
  int url_id;
  String orig_url;
  String short_url;
  int created_at;
  int expires_at;
  String creator_ip;
  final int visitor_count;
  int visitor_limit;
  bool is_private;

  factory UrlData.fromJson(Map<String, dynamic> json) {
    //   bool flag = false;

//    if (json['is_done'] == 1) {
//      flag = true;
//    }

    UrlData newModel = UrlData(
      month: json['month'],
      visitor_count: json['visitor_count'],
    );
    return newModel;
  }
}
