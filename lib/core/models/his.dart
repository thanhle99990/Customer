class HisObj {
  int idride;
  String code;
  int idcustomer;
  int iddriver;
  String date;
  String datestart;
  String dateend;
  String from;
  double fromlat;
  double fromlng;
  String to;
  double tolat;
  double tolng;
  String vehicle;
  String status;
  int km;
  int time;
  double price;
  int payment;
  int discount;
  String kmtext;
  String timetext;
  String customer;
  String cprofile;
  String driver;
  String dprofile;

  HisObj(
      {this.idride,
      this.code,
      this.idcustomer,
      this.iddriver,
      this.datestart,
      this.dateend,
      this.from,
      this.fromlat,
      this.fromlng,
      this.to,
      this.tolat,
      this.tolng,
      this.vehicle,
      this.status,
      this.km,
      this.time,
      this.price,
      this.payment,
      this.discount,
      this.kmtext,
      this.timetext,
      this.customer,
      this.cprofile,
      this.driver,
      this.dprofile});

  HisObj.fromJson(Map<String, dynamic> json) {
    idride = json['idride'];
    code = json['code'];
    idcustomer = json['idcustomer'];
    iddriver = json['iddriver'];
    datestart = json['datestart'];
    dateend = json['dateend'];
    date = json['date'];
    from = json['from'];
    fromlat = json['fromlat'];
    fromlng = json['fromlng'];
    to = json['to'];
    tolat = json['tolat'];
    tolng = json['tolng'];
    vehicle = json['vehicle'];
    status = json['status'];
    km = json['km'];
    time = json['time'];
    price = json['price'].toDouble();
    payment = json['payment'];
    discount = json['discount'];
    kmtext = json['kmtext'];
    timetext = json['timetext'];
    customer = json['customer'];
    cprofile = json['cprofile'];
    driver = json['driver'];
    dprofile = json['dprofile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idride'] = this.idride;
    data['code'] = this.code;
    data['idcustomer'] = this.idcustomer;
    data['iddriver'] = this.iddriver;
    data['datestart'] = this.datestart;
    data['dateend'] = this.dateend;
    data['date'] = this.date;
    data['from'] = this.from;
    data['fromlat'] = this.fromlat;
    data['fromlng'] = this.fromlng;
    data['to'] = this.to;
    data['tolat'] = this.tolat;
    data['tolng'] = this.tolng;
    data['vehicle'] = this.vehicle;
    data['status'] = this.status;
    data['km'] = this.km;
    data['time'] = this.time;
    data['price'] = this.price;
    data['payment'] = this.payment;
    data['discount'] = this.discount;
    data['kmtext'] = this.kmtext;
    data['timetext'] = this.timetext;
    data['customer'] = this.customer;
    data['cprofile'] = this.cprofile;
    data['driver'] = this.driver;
    data['dprofile'] = this.dprofile;
    return data;
  }
}
