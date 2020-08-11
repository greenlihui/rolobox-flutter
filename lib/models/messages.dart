// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);

import 'dart:convert';

class Messages {
  List<Datum> data;

  Messages({
    this.data,
  });

  factory Messages.fromRawJson(String str) => Messages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  bool unread;
  String id;
  String sender;
  String receiver;
  String type;
  String content;
  DateTime timestamp;
  int v;

  Datum({
    this.unread,
    this.id,
    this.sender,
    this.receiver,
    this.type,
    this.content,
    this.timestamp,
    this.v,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
