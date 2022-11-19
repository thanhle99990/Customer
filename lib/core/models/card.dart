class CardObj {
  int idcard;
  String name;
  String number;
  String date;
  String cvv;
  int type;
  int iduser;

  CardObj(
      {this.idcard,
      this.name,
      this.number,
      this.date,
      this.cvv,
      this.type,
      this.iduser});

  CardObj.fromJson(Map<String, dynamic> json) {
    idcard = json['idcard'];
    name = json['name'];
    number = json['number'];
    date = json['date'];
    cvv = json['cvv'];
    type = json['type'];
    iduser = json['iduser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcard'] = this.idcard;
    data['name'] = this.name;
    data['number'] = this.number;
    data['date'] = this.date;
    data['cvv'] = this.cvv;
    data['type'] = this.type;
    data['iduser'] = this.iduser;
    return data;
  }
}
