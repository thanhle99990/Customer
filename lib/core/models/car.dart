class CarObj {
  int idcar;
  int type;
  String model;
  String plate;
  String color;
  int iddriver;
  int seat;
  int idvehicle;
  String typename;
  String image;
  int cost;
  int active;

  CarObj(
      {this.idcar,
      this.type,
      this.model,
      this.plate,
      this.color,
      this.iddriver,
      this.seat,
      this.idvehicle,
      this.typename,
      this.image,
      this.cost,
      this.active});

  CarObj.fromJson(Map<String, dynamic> json) {
    idcar = json['idcar'];
    type = json['type'];
    model = json['model'];
    plate = json['plate'];
    color = json['color'];
    iddriver = json['iddriver'];
    seat = json['seat'];
    idvehicle = json['idvehicle'];
    typename = json['typename'];
    image = json['image'];
    cost = json['cost'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcar'] = this.idcar;
    data['type'] = this.type;
    data['model'] = this.model;
    data['plate'] = this.plate;
    data['color'] = this.color;
    data['iddriver'] = this.iddriver;
    data['seat'] = this.seat;
    data['idvehicle'] = this.idvehicle;
    data['typename'] = this.typename;
    data['image'] = this.image;
    data['cost'] = this.cost;
    data['active'] = this.active;
    return data;
  }
}
