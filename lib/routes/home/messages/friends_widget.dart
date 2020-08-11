import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/main.dart';
import 'package:rolobox/models/get_friends_response.dart';
import 'package:rolobox/routes/home/contacts/contact_detail_widget.dart';
import 'package:rolobox/routes/home/messages/qrcode_widget.dart';
import 'package:rolobox/routes/home/messages/scan_widget.dart';
import 'package:rolobox/shared/http_utils.dart';

class FriendsWidget extends StatefulWidget {
  @override
  _FriendsWidgetState createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(content: Text('Friend request has successfully been sent.'));

  Future<FriendsResponse> _getFriends () async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response response =
        await HttpUtil.getInstance().get("/users/$userId/friends");
    FriendsResponse friends = FriendsResponse.fromJson(response.data);
    return Future<FriendsResponse>.value(friends);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Friends'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () async  {
                  String email = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanWidget()));
                  if (email != null) {
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  }
              }
          ),
          IconButton(
            icon: Icon(Icons.center_focus_strong),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => QrCodeWidget())),
          )
        ],
      ),
      body: FutureBuilder(
        future: _getFriends(),
        builder: (ct, AsyncSnapshot<FriendsResponse> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data.data.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) => FriendWidget(
                friend: snapshot.data.data.elementAt(index),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      )
    );
  }
}

class FriendWidget extends StatelessWidget {
  final Datum friend;

  String _thumbnailImageUrl(imageFilename) {
    return "http://192.168.1.44:3000/api/v1/users/aaa/faceThumbnails/$imageFilename";
  }

  FriendWidget({this.friend});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage:
        NetworkImage(_thumbnailImageUrl(friend.profile.faces.avatar)),
      ),
      title: Text(friend.profile.name.full),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactDetailWidget(
                  groupId: "aaa",
                  contactId: friend.profile.id,
                ))),
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () => null,
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
    );
  }
}

