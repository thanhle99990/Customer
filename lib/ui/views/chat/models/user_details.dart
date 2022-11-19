class UserDetails {
  String name;
  String emailId;
  String photoUrl;
  String uid;
  String phone;
  String token;

  UserDetails({this.name, this.emailId, this.photoUrl, this.uid, this.phone});

  Map toMap(UserDetails userDetails) {
    var data = Map<String, String>();
    data['name'] = userDetails.name;
    data['emailId'] = userDetails.emailId;
    data['photoUrl'] = userDetails.photoUrl;
    data['uid'] = userDetails.uid;
    data['phone'] = userDetails.phone;
    data['token'] = userDetails.token;
    return data;
  }

  UserDetails.fromMap(Map<String, String> mapData) {
    this.name = mapData['name'];
    this.emailId = mapData['emailId'];
    this.photoUrl = mapData['photoUrl'];
    this.uid = mapData['uid'];
    this.phone = mapData['phone'];
    this.token = mapData['token'];
  }
}
