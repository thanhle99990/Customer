class FinalOrderObj {
  String code;
  int idcustomer;
  int productid;
  int senderid;
  int receiverid;
  int price;
  String pin;
  int time;
  int timeminus;
  int km;
  String driverstatus;
  int iddriver;

  FinalOrderObj(
      {this.code,
      this.idcustomer,
      this.productid,
      this.senderid,
      this.receiverid,
      this.price,
      this.pin,
      this.time,
      this.timeminus,
      this.km,
      this.driverstatus,
      this.iddriver});

  FinalOrderObj.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    idcustomer = json['idcustomer'];
    productid = json['productid'];
    senderid = json['senderid'];
    receiverid = json['receiverid'];
    price = json['price'];
    pin = json['pin'];
    time = json['time'];
    timeminus = json['timeminus'];
    km = json['km'];
    driverstatus = json['driverstatus'];
    iddriver = json['iddriver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['idcustomer'] = this.idcustomer;
    data['productid'] = this.productid;
    data['senderid'] = this.senderid;
    data['receiverid'] = this.receiverid;
    data['price'] = this.price;
    data['pin'] = this.pin;
    data['time'] = this.time;
    data['timeminus'] = this.timeminus;
    data['km'] = this.km;
    data['driverstatus'] = this.driverstatus;
    data['iddriver'] = this.iddriver;
    return data;
  }
}
