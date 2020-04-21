class UrlData {
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
      this.month});

  int url_id;
  String orig_url;
  String short_url;
  String created_at;
  int expires_at;
  String creator_ip;
  final int visitor_count;
  int visitor_limit;
  bool is_private;
  String month;

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
