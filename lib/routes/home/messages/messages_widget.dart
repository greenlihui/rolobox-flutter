import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/main.dart';
import 'package:rolobox/models/friends_in_conversation.dart';
import 'package:rolobox/models/latest_msg_data.dart';
import 'package:rolobox/routes/home/messages/chat_widget.dart';
import 'package:rolobox/routes/home/messages/friends_widget.dart';
import 'package:rolobox/shared/http_utils.dart';

class MessagesWidget extends StatefulWidget {
  @override
  State createState() {
    return MessagesWidgetState();
  }
}

class MessagesWidgetState extends State<MessagesWidget> {
  
  Future<FriendInConversation> _getFriendsInConversation() async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response r = await HttpUtil.getInstance()
        .get('/users/$userId/friendsInConversation');
    FriendInConversation friends = FriendInConversation.fromJson(r.data);
    return Future.value(friends);
  }
  
  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.group,
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsWidget())),
          )
        ],
      ),
      body: FutureBuilder(
        future: _getFriendsInConversation(),
        builder: (context, AsyncSnapshot<FriendInConversation> snap) {
          if (snap.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) =>
                    ChatItem(friend: snap.data.data.elementAt(index),
                      userId: userId,),
                separatorBuilder: (_, __) => Divider(),
                itemCount: snap.data.data.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ChatItem extends StatefulWidget {
  Datum friend;
  String userId;

  ChatItem({Key key, this.friend, this.userId}) : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  String _thumbnailImageUrl(imageFilename) {
    return "http://192.168.1.44:3000/api/v1/users/${widget.userId}/faceThumbnails/$imageFilename";
  }

  Future<LatestMsgData> _getLatestMsg() async {
    Response r = await HttpUtil.getInstance()
        .get('/users/${widget.userId}/friends/${widget.friend.id}/latestMsgData');
    LatestMsgData msgData = LatestMsgData.fromJson(r.data);
    return Future.value(msgData);
  }

  _formatMsgContent(String content) {
    return (content.length < 24) ? content : content.substring(0, 24) + '...';
  }

  _formatMsgData(DateTime time) {
    String today = DateFormat.yMd().format(DateTime.now());
    String msgDate = DateFormat.yMd().format(time);
    if (today != msgDate) {
      return msgDate;
    } else {
      return DateFormat.Hms().format(time);
    }
  }


  @override
  Widget build(BuildContext context) {
    final TextStyle timeTextStyle = TextStyle(
      color: Theme.of(context).primaryColor,
    );
    final TextStyle usernameTextStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
    final TextStyle messageContentStyle = TextStyle(
      color: Theme.of(context).textTheme.caption.color,
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ChatPage(friend: widget.friend,)));
      },
      child: Container(
        height: 72,
        child: FutureBuilder(
          future: _getLatestMsg(),
          builder: (BuildContext context, AsyncSnapshot<LatestMsgData> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(_thumbnailImageUrl(widget.friend.profile.faces.avatar)),
                        radius: 28,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.friend.profile.name.full,
                            style: usernameTextStyle,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            _formatMsgContent(snapshot.data.latestMsg.content),
                            style: messageContentStyle,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _formatMsgData(snapshot.data.latestMsg.timestamp),
                          style: timeTextStyle,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: snapshot.data.unreadCount == 0 ? Colors.white : Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            child: Text(
                              snapshot.data.unreadCount.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

