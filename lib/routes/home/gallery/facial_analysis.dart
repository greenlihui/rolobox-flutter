import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/main.dart';
import 'package:rolobox/models/all_contacts_response.dart' as acr;
import 'package:rolobox/models/analysis_response.dart';
import 'package:rolobox/shared/http_utils.dart';
import 'package:rolobox/models/similar_face_response.dart' as sfr;
import 'package:rolobox/models/upload_response.dart';

//class FacialAnalysisWidget extends StatelessWidget {
//  final String imagePath;
//
//  FacialAnalysisWidget({this.imagePath});
//
//  @override
//  Widget build(BuildContext context) {
//    print("+++++");
//    return Container(
//      child: PhotoView(
//        imageProvider: FileImage(File(imagePath)),
//      ),
//    );
//  }
//}

class FacialAnalysisWidget extends StatefulWidget {
  String imagePath;

  FacialAnalysisWidget({Key key, this.imagePath}) : super(key: key);

  @override
  _FacialAnalysisWidgetState createState() => _FacialAnalysisWidgetState();
}

class _FacialAnalysisWidgetState extends State<FacialAnalysisWidget> {
  String imageFilename;
  AnalysisResponse analysisResponse;

  int currentSelectIndex = 0;

  Future<UploadResponse> upload() async {
    FormData formData = new FormData.fromMap({
      "imageUpload": await MultipartFile.fromFile(widget.imagePath),
    });
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response response = await HttpUtil.getInstance().post(
      "/users/$userId/images",
      data: formData,
    );
    return Future.value(UploadResponse.fromJson(response.data));
  }

  Future<AnalysisResponse> analyze(String imageFilename) async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response response = await HttpUtil.getInstance()
        .get("/users/$userId/images/$imageFilename/analysis");
    return Future.value(AnalysisResponse.fromJson(response.data));
  }

  _initData() async {
    UploadResponse uploadResponse = await upload();
    AnalysisResponse ar = await analyze(uploadResponse.data.filename);
    if (mounted) {
      setState(() {
        imageFilename = uploadResponse.data.filename;
        analysisResponse = ar;
      });
    }
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  String _thumbnailImageUrl(imageFilename) {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    return "http://192.168.1.44:3000/api/v1/users/$userId/faceThumbnails/$imageFilename";
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Facial Analysis'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Image",
              ),
              Tab(
                text: "Analysis",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  child: PhotoView(
                    imageProvider: FileImage(File(widget.imagePath)),
                  ),
                ),
                Center(
                    child: analysisResponse == null
                        ? CircularProgressIndicator()
                        : null),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: analysisResponse == null
                  ? null
                  : Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            scrollDirection: Axis.horizontal,
                            itemCount: analysisResponse.data.length,
                            separatorBuilder: (_, index) => SizedBox(
                              width: 8,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    currentSelectIndex = index;
                                  });
                                }
                              },
                              child: Material(
                                elevation: currentSelectIndex == index ? 4 : 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                child: Container(
                                  width: 82,
                                  height: 82,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(_thumbnailImageUrl(
                                          analysisResponse.data
                                              .elementAt(index)
                                              .thumbnailImageFilename)),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: currentSelectIndex == index
                                          ? Colors.yellow
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: AnalysisList(
                            analysisData: analysisResponse.data
                                .elementAt(currentSelectIndex),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: RaisedButton(
                            child: Text('Add to Contact List'),
                            onPressed: () => addToContacts(context),
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) => Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.person_add),
                  title: new Text('Create a New Contact'),
                  onTap: () => {}),
              new ListTile(
                leading: new Icon(Icons.edit),
                title: new Text('Attach to Existing Contact'),
                onTap: () {
                  Navigator.of(context).pop();
                  _manuallyAttachDialog(analysisResponse.data
                      .elementAt(currentSelectIndex)
                      .thumbnailImageFilename);
                },
              ),
            ],
          ),
        ));
  }

  void addToContacts(BuildContext context) async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    String faceThumbnailFilename = analysisResponse.data
        .elementAt(currentSelectIndex)
        .thumbnailImageFilename;
    Response response = await HttpUtil.getInstance().get(
        "/users/$userId/faces/$faceThumbnailFilename/contactsWithSimilarFaces");
    sfr.SimilarFaceResponse similarFaceResponse =
        sfr.SimilarFaceResponse.fromJson(response.data);
    if (similarFaceResponse.data.length == 0) {
      _openBottomSheet();
    } else {
      _autoAttachDialog(faceThumbnailFilename, similarFaceResponse);
    }
  }

  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<acr.Datum>>();

  AutoCompleteTextField<acr.Datum> textField;

  acr.Datum selected;

  Future<void> _manuallyAttachDialog(String thumbnailFilename) async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response response = await HttpUtil.getInstance().get("/users/$userId/contacts");
    print(response.data);
    acr.AllContactsResponse res = acr.AllContactsResponse.fromJson(response.data);
    List<acr.Datum> contacts = res.data;

    textField = new AutoCompleteTextField<acr.Datum>(
      decoration: new InputDecoration(
          hintText: "Search Contacts:", suffixIcon: new Icon(Icons.search)),
      itemSubmitted: (item) {
        Navigator.of(context).pop();
        _attachFaceToExisting(thumbnailFilename, item.id);
      },
      key: key,
      suggestions: contacts,
      itemBuilder: (context, suggestion) => new Padding(
          child: new ListTile(
//            leading: CircleAvatar(backgroundImage: NetworkImage(_thumbnailImageUrl(suggestion.faces.avatar)),),
              title: new Text(suggestion.name.full),),
          padding: EdgeInsets.all(8.0)),
      itemSorter: (a, b) => a.id.toString().compareTo(b.id.toString()),
      itemFilter: (suggestion, input) =>
          suggestion.name.full.toLowerCase().startsWith(input.toLowerCase()),
    );

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Attach Faces'),
          content: Container(
            child: textField,
          ),
        );
      }
    );
  }

  Future<void> _autoAttachDialog(
      String thumbnailFilename, sfr.SimilarFaceResponse response) async {
    String toAttachId;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Face Matches'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _thumbnailImageUrl(thumbnailFilename),
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Expanded(
                      child: Text(
                          'This person seems to be one of the following contacts.'),
                    ),
                  ],
                ),
                Divider(),
                ListView.builder(
                  itemBuilder: (ct, index) => Column(
                    children: <Widget>[
                      Text(response.data.elementAt(index).name.full),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Radio(
                            value: response.data.elementAt(index).id,
                            groupValue: response.data.elementAt(index).id,
                            onChanged: (String val) {
                            },
                          ),
                          SizedBox(
                            height: 100,
                            width: 180,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: response.data
                                  .elementAt(index)
                                  .faces
                                  .list
                                  .length,
                              itemBuilder: (bc, i) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    _thumbnailImageUrl(response.data.elementAt(index).faces.list.elementAt(i).thumbnailImageFilename),
                                    height: 80,
                                    width: 80,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  itemCount: response.data.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                _openBottomSheet();
              },
            ),
            FlatButton(
              child: Text('Attach'),
              onPressed: () {
                _attachFaceToExisting(thumbnailFilename, response.data.first.id);
              },
            ),
          ],
        );
      },
    );
  }
  
  _attachFaceToExisting(thumbnailImageFilename, contactId) async {
    print(thumbnailImageFilename);
    print(contactId);
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response response = await HttpUtil.getInstance().post("/users/$userId/images/$imageFilename/faces?contactOrigin=EXISTING", data: {
      "thumbnailImageFilename": thumbnailImageFilename, "contactId": contactId
    });
    print(response.data);
    Navigator.pop(context);
  }
}

class AnalysisList extends StatelessWidget {
  final Datum analysisData;

  AnalysisList({this.analysisData});

  String _valueToFixed(double value) {
    return "${value.toStringAsFixed(2)}%";
  }

  @override
  Widget build(BuildContext context) {
    List<AnalysisItem> items = [
      AnalysisItem(
        name: "looks like a face",
        value: _valueToFixed(analysisData.confidence),
      ),
      AnalysisItem(
        name: "age range",
        value: "${analysisData.ageRange.low} - ${analysisData.ageRange.high}",
      ),
      AnalysisItem(
        name: "appears to be ${analysisData.gender.value}",
        value: _valueToFixed(analysisData.gender.confidence),
      ),
      AnalysisItem(
        name: analysisData.smile.value ? "smiling" : "not smiling",
        value: _valueToFixed(analysisData.smile.confidence),
      ),
      AnalysisItem(
        name: "${analysisData.eyeglasses.value ? "" : "not"} wearing glasses",
        value: _valueToFixed(analysisData.eyeglasses.confidence),
      ),
      AnalysisItem(
        name:
            "${analysisData.sunglasses.value ? "" : "not"} wearing sunglasses",
        value: _valueToFixed(analysisData.sunglasses.confidence),
      ),
      AnalysisItem(
        name: "${analysisData.beard.value ? "has" : "does not have"} a beard",
        value: _valueToFixed(analysisData.beard.confidence),
      ),
      AnalysisItem(
        name:
            "${analysisData.mustache.value ? "has" : "does not have"} a mustache",
        value: _valueToFixed(analysisData.mustache.confidence),
      ),
    ];
    return ListView.separated(
      itemBuilder: (_, index) {
        return items.elementAt(index);
      },
      separatorBuilder: (_, __) => Divider(),
      itemCount: 8,
    );
  }
}

class AnalysisItem extends StatelessWidget {
  final String name;
  final String value;

  AnalysisItem({this.name, this.value});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            name,
            style: textStyle,
          ),
          Text(
            value,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
