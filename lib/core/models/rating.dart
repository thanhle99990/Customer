class RatingObj {
  int id;
  int idride;
  int idcustomer;
  int iddriver;
  int rating;
  String comment;
  String date;
  int fromcustomer;
  String code;
  String name;

  RatingObj(
      {this.id,
      this.idride,
      this.idcustomer,
      this.iddriver,
      this.rating,
      this.comment,
      this.date,
      this.fromcustomer,
      this.code,
      this.name});

  RatingObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idride = json['idride'];
    idcustomer = json['idcustomer'];
    iddriver = json['iddriver'];
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    fromcustomer = json['fromcustomer'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idride'] = this.idride;
    data['idcustomer'] = this.idcustomer;
    data['iddriver'] = this.iddriver;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['date'] = this.date;
    data['fromcustomer'] = this.fromcustomer;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}
