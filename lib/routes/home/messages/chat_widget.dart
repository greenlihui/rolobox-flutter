import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/models/friends_in_conversation.dart' as fic;
import 'package:rolobox/models/index.dart';
import 'package:rolobox/models/messages.dart';
import 'package:rolobox/models/response1.dart';
import 'package:rolobox/shared/http_utils.dart';

import '../../../main.dart';

class MessageItemWidget extends StatelessWidget {
  Datum msg;
  String avatarUrl;
  bool receivedMsg;

  MessageItemWidget({this.msg, this.avatarUrl, this.receivedMsg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: receivedMsg ? TextDirection.ltr : TextDirection.rtl,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: receivedMsg ? Colors.white : Colors.teal),
              child: Text(
                msg.content,
                style: TextStyle(
                  color: receivedMsg ? Colors.black : Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  fic.Datum friend;

  ChatPage({Key key, this.friend}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Datum> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();
  bool _disableSending = true;

  SocketIO socket;

  Future<Messages> _getMessage() async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response r = await HttpUtil.getInstance()
        .get('/users/$userId/friends/${widget.friend.id}/messages');
    Messages msgs = Messages.fromJson(r.data);
    return Future.value(msgs);
  }

  @override
  void initState() {
    super.initState();
    _getMessage().then((msgs) {
      setState(() {
        this._messages.addAll(msgs.data);
      });
    });
    initSocket();
  }

  initSocket() async {
    socket = await SocketIOManager().createInstance(SocketOptions(
        //Socket IO server URI
        'http://192.168.1.44',
        nameSpace: "/",
        // Enable or disable platform channel logging
        enableLogging: true,
        transports: [
          Transports.WEB_SOCKET /*, Transports.POLLING*/
        ]));
    socket.onConnect((data) {
      print('################');
    });
    socket.on("receiveMsg", (data) {
      Datum msg = Datum.fromJson(data);
      setState(() {
        this._messages.add(msg);
      });
    });
    socket.connect();
    socket.emit(
        "signin", [Provider.of<User>(context, listen: false).userData.data.id]);
  }

  String _avatarUrl(Datum msg) {
    UserResponse1 user = Provider.of<User>(context, listen: false).userData;
    String imageFilename = msg.sender == user.data.id
        ? user.data.profile.faces.avatar
        : widget.friend.profile.faces.avatar;
    return "http://192.168.1.44:3000/api/v1/users/${user.data.id}/faceThumbnails/$imageFilename";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend.profile.name.full),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                reverse: false,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  Datum msg = _messages.elementAt(index);
                  return MessageItemWidget(
                    msg: msg,
                    avatarUrl: _avatarUrl(msg),
                    receivedMsg: (widget.friend.id == msg.sender),
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _msgInputWidget(),
          )
        ],
      ),
    );
  }

  Widget _msgInputWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textEditingController,
              onChanged: (String text) {
                setState(() {
                  _disableSending = text.trim().length == 0;
                });
              },
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              onSubmitted: null,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: _disableSending
                  ? null
                  : () => sendMsg(_textEditingController.text),
            ),
          ),
        ],
      ),
    );
  }

  void sendMsg(String text) {
    _textEditingController.clear();
    setState(() {
      _disableSending = true;
    });
    socket.emit("sendMsg", [
      {
        "sender": Provider.of<User>(context, listen: false).userData.data.id,
        "receiver": widget.friend.id,
        "type": 'TEXT',
        "content": text,
        "unread": true
      }
    ]);
  }
}
