import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode/qrcode.dart';
import 'package:rolobox/shared/http_utils.dart';

import '../../../main.dart';

class ScanWidget extends StatefulWidget {
  @override
  _ScanWidgetState createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> with TickerProviderStateMixin {
  QRCaptureController _captureController = QRCaptureController();
  Animation<Alignment> _animation;
  AnimationController _animationController;

  bool _isTorchOn = false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<Response> _sendRequest(String email) async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response r = await HttpUtil.getInstance().post('/users/$userId/friend-requests', data: {
      "requester": userId,
      "recipient": email
    });
  }

  @override
  void initState() {
    super.initState();
    _captureController.onCapture((data) {
      List<String> code = data.split(":");
      if (code.length == 3
          && code[0] == 'rolobox'
          && code[1] == 'addfriend') {
        _captureController.pause();
        _sendRequest(code[2]).then((response) {
          Navigator.pop(context, code[2]);
        });
      } else {
        print("wrong data");
      }
    });

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
    AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomCenter)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            QRCaptureView(controller: _captureController),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildToolBar(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 56),
              child: AspectRatio(
                aspectRatio: 264 / 258.0,
                child: Stack(
                  alignment: _animation.value,
                  children: <Widget>[
                    Image.asset('assets/sao@3x.png'),
                    Image.asset('assets/tiao@3x.png')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          iconSize: 32,
          icon: Icon(Icons.highlight, color: Colors.white,),
          onPressed: () {
            if (_isTorchOn) {
              _captureController.torchMode = CaptureTorchMode.off;
            } else {
              _captureController.torchMode = CaptureTorchMode.on;
            }
            _isTorchOn = !_isTorchOn;
          },
        ),
      ],
    );
  }
}
