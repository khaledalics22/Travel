enum MsgStauts {
  SEEN,
  SENT,
  FAILED,
}

class Message {
  String body;
  bool isImg;
  String imgUrl;
  String authImg;
  bool isVid;
  String videoUrl;
  int date;
  String authId;
  String msgId;
  MsgStauts status;
  Message(
      {this.authId,
      this.body,
      this.msgId,
      this.date,
      this.authImg,
      this.imgUrl,
      this.isImg,
      this.isVid,
      this.status,
      this.videoUrl});
}
