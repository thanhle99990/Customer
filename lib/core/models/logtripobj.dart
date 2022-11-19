class LogTripObj {
  String tripid;
  String ngay;
  String name;
  String profileImage;
  String status;
  String from;
  String to;

  LogTripObj(
      {this.tripid,
      this.ngay,
      this.name,
      this.profileImage,
      this.status,
      this.from,
      this.to});

  LogTripObj.fromJson(Map<String, dynamic> json) {
    tripid = json['tripid'];
    ngay = json['ngay'];
    name = json['name'];
    profileImage = json['profile_image'];
    status = json['status'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tripid'] = this.tripid;
    data['ngay'] = this.ngay;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['status'] = this.status;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
