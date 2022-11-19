class Post {
  int idcustomer;
  int id;
  String title;
  String body;

  Post({this.idcustomer, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    idcustomer = json['idcustomer'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcustomer'] = this.idcustomer;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
