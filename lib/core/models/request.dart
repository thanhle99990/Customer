class RequestObj {
  int id;
  int idcustomer;
  int iddriver;
  String status;
  String from;
  double fromlat;
  double fromlng;
  String to;
  double tolat;
  double tolng;
  int pay;
  int servicetype;
  int vehicleid;
  String km;
  String time;
  String ngay;

  RequestObj(
      {this.id,
      this.idcustomer,
      this.iddriver,
      this.status,
      this.from,
      this.fromlat,
      this.fromlng,
      this.to,
      this.tolat,
      this.tolng,
      this.pay,
      this.servicetype,
      this.vehicleid,
      this.km,
      this.time,
      this.ngay});

  RequestObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idcustomer = json['idcustomer'];
    iddriver = json['iddriver'];
    status = json['status'];
    from = json['from'];
    fromlat = json['fromlat'];
    fromlng = json['fromlng'];
    to = json['to'];
    tolat = json['tolat'];
    tolng = json['tolng'];
    pay = json['seat'];
    servicetype = json['servicetype'];
    vehicleid = json['vehicleid'];
    km = json['km'];
    time = json['time'];
    ngay = json['ngay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idcustomer'] = this.idcustomer;
    data['iddriver'] = this.iddriver;
    data['status'] = this.status;
    data['from'] = this.from;
    data['fromlat'] = this.fromlat;
    data['fromlng'] = this.fromlng;
    data['to'] = this.to;
    data['tolat'] = this.tolat;
    data['tolng'] = this.tolng;
    data['seat'] = this.pay;
    data['servicetype'] = this.servicetype;
    data['vehicleid'] = this.vehicleid;
    data['km'] = this.km;
    data['time'] = this.time;
    data['ngay'] = this.ngay;
    return data;
  }
}
