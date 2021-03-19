import 'package:flutter/material.dart';
import 'package:travel/providers/user.dart';

class Request with ChangeNotifier {
  Map<String, String> data;
  String _toId;
  String _fromId;
  CustomUser fromUser;
  String id;
  String _status;
  Request(this._fromId, this._toId) {
    _status = 'sent';
  }
  Request.fromJson(data, this.id) {
    _toId = data['to'];
    _fromId = data['from'];
    _status = data['status'];
  }
  Map<String, Object> get toJson {
    return {
      'from': this._fromId,
      'to': this._toId,
      'status': _status,
    };
  }

  String get toId => _toId;
  String get fromId => _fromId;
}
