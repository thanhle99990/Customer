class Rspimage {
  bool success;
  String url;
  String filename;

  Rspimage({this.success, this.url, this.filename});

  Rspimage.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    url = json['url'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['url'] = this.url;
    data['filename'] = this.filename;
    return data;
  }
}
