import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/main.dart';
import 'package:rolobox/models/gallery_response.dart';
import 'package:rolobox/shared/http_utils.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'detection/camera_widget.dart';

class GalleryWidget extends StatefulWidget {
  @override
  State createState() {
    return GalleryWidgetState();
  }
}

class GalleryWidgetState extends State<GalleryWidget> {
  Future<GalleryResponse1> _init() async {
    final String userId =
        Provider.of<User>(context, listen: false).userData.data.id;
    Response resp = await HttpUtil.getInstance().get('/users/$userId/images');
    return Future<GalleryResponse1>.value(GalleryResponse1.fromJson(resp.data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: FutureBuilder(
        future: _init(),
        builder:
            (BuildContext context, AsyncSnapshot<GalleryResponse1> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) => YearList(
                yearData: snapshot.data.data.elementAt(index),
              ),
              itemCount: snapshot.data.data.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera), onPressed: _toCamera),
    );
  }

  void _toCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FaceDetectionPage(),
      ),
    );
  }
}

class YearList extends StatelessWidget {
  final Datum yearData;

  YearList({this.yearData});

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: Container(
        height: 48,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          yearData.year.toString(),
          style: TextStyle(
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      content: Container(
        padding: const EdgeInsets.only(left: 16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => MonthGrid(
            monthData: yearData.content[index],
          ),
          itemCount: yearData.content.length,
        ),
      ),
    );
  }
}

class MonthGrid extends StatelessWidget {
  final Content monthData;

  MonthGrid({this.monthData});

  String _monthToText(int month) {
    return [
      "Jan.",
      "Feb.",
      "Mar.",
      "Apr.",
      "May",
      "June",
      "July",
      "Aug.",
      "Sept.",
      "Oct.",
      "Nov.",
      "Dec."
    ].elementAt(month - 1);
  }

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: Container(
        height: 32,
        alignment: Alignment.centerLeft,
        child: Text(
          _monthToText(monthData.month),
          style: TextStyle(fontSize: 16),
        ),
      ),
      content: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.only(left: 8, right: 4),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.blueGrey[600],
              width: 4,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemBuilder: (context, index) => ImageItem(
            imageFilename: monthData.imageFilenames.elementAt(index),
          ),
          itemCount: monthData.imageFilenames.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        ),
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final String imageFilename;

  ImageItem({this.imageFilename});

  String _compressedImgUrl(String imageName) {
    return "http://192.168.1.44/api/v1/users/aaa/images/$imageName/compressed";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.network(_compressedImgUrl(imageFilename)),
      onTap: () => print(imageFilename),
    );
  }
}
