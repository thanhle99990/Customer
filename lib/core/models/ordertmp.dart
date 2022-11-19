class OrderTmp {
  int id;
  String orderid;
  int status;
  int price;
  String ngay;
  String gio;
  String noidi;
  String noiden;
  String driverstatus;

  OrderTmp(
      {this.id,
      this.orderid,
      this.status,
      this.price,
      this.ngay,
      this.gio,
      this.noidi,
      this.noiden,
      this.driverstatus});

  OrderTmp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderid = json['orderid'];
    status = json['status'];
    price = json['price'];
    ngay = json['ngay'];
    gio = json['gio'];
    noidi = json['noidi'];
    noiden = json['noiden'];
    driverstatus = json['driverstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderid'] = this.orderid;
    data['status'] = this.status;
    data['price'] = this.price;
    data['ngay'] = this.ngay;
    data['gio'] = this.gio;
    data['noidi'] = this.noidi;
    data['noiden'] = this.noiden;
    data['driverstatus'] = this.driverstatus;
    return data;
  }
}
