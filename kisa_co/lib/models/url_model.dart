class UrlData {
  int url_id;
  int user_id;
  String orig_url;
  String short_url;
  int created_at;
  int expires_at;
  String creator_ip;
  final int visitor_count;
  int visitor_limit;
  bool is_private;
  List<dynamic> requests = [];

  UrlData(
      {this.visitor_count,
      this.is_private,
      this.visitor_limit,
      this.creator_ip,
      this.expires_at,
      this.created_at,
      this.short_url,
      this.orig_url,
      this.url_id,
      this.user_id});

  factory UrlData.fromJson(Map<String, dynamic> json) {
    //   bool flag = false;

//    if (json['is_done'] == 1) {
//      flag = true;
//    }

    UrlData newModel = UrlData(
      visitor_count: json['visitor_count'],
    );
    return newModel;
  }
}
