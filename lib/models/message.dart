enum MessageType {
  TEXT,
  CONTACT,
  IMAGE
}

class Message {
  dynamic sender;
  dynamic receiver;
  MessageType type;
  String content;
  bool unread;
  DateTime timestamp;

  Message(this.sender, this.receiver, this.type, this.content, this.unread,
      this.timestamp);
}