import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/main.dart';
import 'package:rolobox/shared/http_utils.dart';
import 'package:rolobox/models/response1.dart';
import 'package:rolobox/routes/home/home.dart';

class SigninWidget extends StatefulWidget {
  @override
  _SigninWidgetState createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _title(BuildContext context) {
    return Text(
      "Welcome Back",
      style: TextStyle(
          fontSize: 32,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _cardTitle(BuildContext context) {
    return Container(
      height: 48,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            width: 8,
            height: 48,
            child: Container(
              color: Theme.of(context).accentColor,
            ),
          ),
          Positioned(
            left: 32,
            height: 48,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "SIGNIN",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Transform.translate(
              offset: Offset(24, 24),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Theme.of(context).accentColor,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  iconSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardBody(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Email",
            ),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Password",
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text('SIGNIN'),
              onPressed: () async {
                Response resp = await HttpUtil.getInstance().post("/signin", data: {
                  "email": _emailController.text,
                  "password": _passwordController.text,
                }, options: Options(contentType:Headers.formUrlEncodedContentType));
                Provider.of<User>(context, listen: false).update(UserResponse1.fromJson(resp.data));
//                print(Provider.of<User>(context)UserResponse1.fromJson(r.data).data.email);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeWidget()));
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FlatButton(
              child: Text('FORGET YOUR PASSWORD?'),
              onPressed: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _thirdPartyButton(String asset) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        child: Container(
          width: 24,
          height: 24,
          child: SvgPicture.asset(asset),
        ),
      ),
    );
  }

  Widget _thirdParty(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _thirdPartyButton("assets/icons/facebook.svg"),
            _thirdPartyButton("assets/icons/twitter.svg"),
            _thirdPartyButton("assets/icons/google.svg"),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _title(context),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _cardTitle(context),
                      _cardBody(context),
                      _thirdParty(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
