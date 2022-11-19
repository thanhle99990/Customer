class VehicleObj {
  int idvehicle;
  String typename;
  String image;
  int cost;
  int active;
  double price;

  VehicleObj(
      {this.idvehicle, this.typename, this.image, this.cost, this.active});

  VehicleObj.fromJson(Map<String, dynamic> json) {
    idvehicle = json['idvehicle'];
    typename = json['typename'];
    image = json['image'];
    cost = json['cost'];
    active = json['active'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idvehicle'] = this.idvehicle;
    data['typename'] = this.typename;
    data['image'] = this.image;
    data['cost'] = this.cost;
    data['active'] = this.active;
    data['price'] = this.price;
    return data;
  }
}
