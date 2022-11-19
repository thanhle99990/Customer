class OrderPrice {
  String code;
  int price;
  int time;
  int km;

  OrderPrice({this.code, this.price, this.time, this.km});

  OrderPrice.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    price = json['price'];
    time = json['time'];
    km = json['km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['price'] = this.price;
    data['time'] = this.time;
    data['km'] = this.km;
    return data;
  }
}
