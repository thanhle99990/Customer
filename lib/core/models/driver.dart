class DriverObj {
  int iddriver;
  String verify;
  String name;
  String email;
  String password;
  String phone;
  String address;
  double latitude;
  double longitude;
  int userStatus;
  int userType;
  String profile;
  String createdDate;
  String token;
  String lastactive;
  int orderid;
  double rating;
  int trip;

  DriverObj(
      {this.iddriver,
      this.verify,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.address,
      this.latitude,
      this.longitude,
      this.userStatus,
      this.userType,
      this.profile,
      this.createdDate,
      this.token,
      this.lastactive,
      this.orderid});

  DriverObj.fromJson(Map<String, dynamic> json) {
    iddriver = json['iddriver'];
    verify = json['verify'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userStatus = json['user_status'];
    userType = json['user_type'];
    profile = json['profile'];
    createdDate = json['created_date'];
    token = json['token'];
    lastactive = json['lastactive'];
    orderid = json['orderid'];
    rating = json['rating'].toDouble();
    trip = json['trip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iddriver'] = this.iddriver;
    data['verify'] = this.verify;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['user_status'] = this.userStatus;
    data['user_type'] = this.userType;
    data['profile'] = this.profile;
    data['created_date'] = this.createdDate;
    data['token'] = this.token;
    data['lastactive'] = this.lastactive;
    data['orderid'] = this.orderid;
    data['rating'] = this.rating;
    data['trip'] = this.trip;
    return data;
  }
}
