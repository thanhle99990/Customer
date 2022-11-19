class PlaceObj {
  int idplace;
  String name;
  String address;
  double lng;
  double lat;
  int type;
  int idcustomer;
  double heading;

  PlaceObj(
      {this.idplace,
      this.name,
      this.address,
      this.lng,
      this.lat,
      this.type,
      this.idcustomer});

  PlaceObj.fromJson(Map<String, dynamic> json) {
    idplace = json['idplace'];
    name = json['name'];
    address = json['address'];
    lng = json['lng'];
    lat = json['lat'];
    type = json['type'];
    idcustomer = json['idcustomer'];
    heading = json['heading'];
  }

  Map<String, dynamic> toJson() {// chuyển hóa Object thành một mã JSON với đầy đủ các cột attribute trong đó
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.idplace;
    data['name'] = this.name;
    data['address'] = this.address;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['type'] = this.type;
    data['idcustomer'] = this.idcustomer;
    data['heading'] = this.heading;
    return data;
  }
}
