import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/shared/http_utils.dart';
import 'package:rolobox/models/response1.dart';
import 'package:rolobox/routes/home/home.dart';
import 'package:rolobox/routes/index.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => User(),
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  static const String _title = 'RoloBox';

  Future _initUser() {
    return HttpUtil.getInstance().get("/init");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.blueGrey[800],
        accentColor: Colors.teal[700],
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: FutureBuilder(
        future: _initUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            UserResponse1 response = UserResponse1.fromJson(snapshot.data.data);
            Provider.of<User>(context, listen: false).update(response);
            return response.data == null ? SigninWidget() : HomeWidget();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}


class User extends ChangeNotifier {
  UserResponse1 userData;
  String baseUrl = "http://192.168.1.44:3000/api/v1";

  void update(UserResponse1 userResponse1) {
    userData = userResponse1;
    notifyListeners();
  }

  String avatarUrl() {
    return '$baseUrl/users/${userData.data.id}/faceThumbnails/${userData.data.profile.faces.avatar}';
  }
}
