// To parse this JSON data, do
//
//     final latestMsgData = latestMsgDataFromJson(jsonString);

import 'dart:convert';

class LatestMsgData {
  LatestMsg latestMsg;
  int unreadCount;

  LatestMsgData({
    this.latestMsg,
    this.unreadCount,
  });

  factory LatestMsgData.fromRawJson(String str) => LatestMsgData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LatestMsgData.fromJson(Map<String, dynamic> json) => LatestMsgData(
    latestMsg: json["latestMsg"] == null ? null : LatestMsg.fromJson(json["latestMsg"]),
    unreadCount: json["unreadCount"] == null ? null : json["unreadCount"],
  );

  Map<String, dynamic> toJson() => {
    "latestMsg": latestMsg == null ? null : latestMsg.toJson(),
    "unreadCount": unreadCount == null ? null : unreadCount,
  };
}

class LatestMsg {
  bool unread;
  String id;
  String sender;
  String receiver;
  String type;
  String content;
  DateTime timestamp;
  int v;

  LatestMsg({
    this.unread,
    this.id,
    this.sender,
    this.receiver,
    this.type,
    this.content,
    this.timestamp,
    this.v,
  });

  factory LatestMsg.fromRawJson(String str) => LatestMsg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LatestMsg.fromJson(Map<String, dynamic> json) => LatestMsg(
    unread: json["unread"] == null ? null : json["unread"],
    id: json["_id"] == null ? null : json["_id"],
    sender: json["sender"] == null ? null : json["sender"],
    receiver: json["receiver"] == null ? null : json["receiver"],
    type: json["type"] == null ? null : json["type"],
    content: json["content"] == null ? null : json["content"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "unread": unread == null ? null : unread,
    "_id": id == null ? null : id,
    "sender": sender == null ? null : sender,
    "receiver": receiver == null ? null : receiver,
    "type": type == null ? null : type,
    "content": content == null ? null : content,
    "timestamp": timestamp == null ? null : timestamp.toIso8601String(),
    "__v": v == null ? null : v,
  };
}
