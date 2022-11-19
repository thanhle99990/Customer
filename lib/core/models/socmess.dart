class SocMessObj {
  String content;
  String senderChatID;
  String receiverChatID;

  SocMessObj({this.content, this.senderChatID, this.receiverChatID});

  SocMessObj.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    senderChatID = json['senderChatID'];
    receiverChatID = json['receiverChatID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['senderChatID'] = this.senderChatID;
    data['receiverChatID'] = this.receiverChatID;
    return data;
  }
}
