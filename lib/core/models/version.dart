class VersionObj {
  int vscode;
  String version;
  String date;
  String apk;

  VersionObj({this.vscode, this.version, this.date});

  VersionObj.fromJson(Map<String, dynamic> json) {
    vscode = json['vscode'];
    version = json['version'];
    date = json['date'];
    apk = json['apk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vscode'] = this.vscode;
    data['version'] = this.version;
    data['date'] = this.date;
    data['apk'] = this.apk;
    return data;
  }
}
