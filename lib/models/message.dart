enum MsgStauts {
  SEEN,
  SENT,
  FAILED,
}

class Message {
  String body;
  bool isImg;
  String imgUrl;
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
      this.imgUrl,
      this.isImg,
      this.isVid,
      this.status,
      this.videoUrl});

  Message.fromJson(data){
     this.authId=data['authorId'];
     this.body=data[ 'body'];
     this.msgId=data[ 'msgId'];
     this.imgUrl=data[ 'imageUrl'];
     this.date=data[ 'date'];
     this.isImg=data[ 'isImage'];
     this.isVid=data[ 'isVideo'];
     this.status=data[ 'status'];
     this.videoUrl=data[ 'videoUrl'];
  }

  Map<String, Object> get toJson {
    return {
      'authorId': this.authId,
      'body': this.body,
      'msgId': this.msgId,
      'imageUrl': this.imgUrl,
      'date': this.date,
      'isImage': this.isImg,
      'isVideo': this.isVid,
      'status': this.status,
      'videoUrl': this.videoUrl,
    };
  }

}
