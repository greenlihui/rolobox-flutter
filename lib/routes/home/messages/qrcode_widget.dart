
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../main.dart';

class QrCodeWidget extends StatefulWidget {
  @override
  _QrCodeWidgetState createState() => _QrCodeWidgetState();
}

class _QrCodeWidgetState extends State<QrCodeWidget> {
  String value = 'hello';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String email = Provider.of<User>(context, listen: false).userData.data.email;
    setState(() {
      value = 'rolobox:addfriend:$email';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(
        child: QrImage(
          data: value,
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        )
      ),
    );
  }
}
