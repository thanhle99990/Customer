class Driverorder {
  int id;
  int iddriver;
  int orderid;
  int status;
  String createDate;

  Driverorder(
      {this.id, this.iddriver, this.orderid, this.status, this.createDate});

  Driverorder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iddriver = json['iddriver'];
    orderid = json['orderid'];
    status = json['status'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iddriver'] = this.iddriver;
    data['orderid'] = this.orderid;
    data['status'] = this.status;
    data['create_date'] = this.createDate;
    return data;
  }
}
