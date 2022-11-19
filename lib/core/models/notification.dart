class NotifyObj {
  int idnoti;
  String message;
  String title;
  int iduser;
  String createdate;
  String code;
  int isdriver;
  String date;

  NotifyObj(
      {this.idnoti,
        this.message,
        this.title,
        this.iduser,
        this.createdate,
        this.code,
        this.isdriver,
        this.date});

  NotifyObj.fromJson(Map<String, dynamic> json) {
    idnoti = json['idnoti'];
    message = json['message'];
    title = json['title'];
    iduser = json['iduser'];
    createdate = json['createdate'];
    code = json['code'];
    isdriver = json['isdriver'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idnoti'] = this.idnoti;
    data['message'] = this.message;
    data['title'] = this.title;
    data['iduser'] = this.iduser;
    data['createdate'] = this.createdate;
    data['code'] = this.code;
    data['isdriver'] = this.isdriver;
    data['date'] = this.date;
    return data;
  }
}
