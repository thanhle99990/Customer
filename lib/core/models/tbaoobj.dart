class TbaoObj {
  bool isshow;
  String noidung;

  TbaoObj({this.isshow, this.noidung});

  TbaoObj.fromJson(Map<String, dynamic> json) {
    isshow = json['isshow'];
    noidung = json['noidung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isshow'] = this.isshow;
    data['noidung'] = this.noidung;
    return data;
  }
}
