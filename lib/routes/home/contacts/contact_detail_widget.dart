import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/main.dart';
import 'package:rolobox/models/contact_response.dart';
import 'package:rolobox/shared/http_utils.dart';

class ContactDetailWidget extends StatefulWidget {
  String groupId;
  String contactId;

  ContactDetailWidget({Key key, @required this.groupId, @required this.contactId})
      : super(key: key);

  @override
  _ContactDetailWidgetState createState() => _ContactDetailWidgetState();
}

class _ContactDetailWidgetState extends State<ContactDetailWidget> {
  bool onEdit = false;

  Future<ContactResponse> _getContact() async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response response = await HttpUtil.getInstance().get(
        "/users/$userId/groups/${widget.groupId}/contacts/${widget.contactId}");
    return Future<ContactResponse>.value(
        ContactResponse.fromJson(response.data));
  }

  String _thumbnailImageUrl(imageFilename) {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    return "http://192.168.1.44:3000/api/v1/users/$userId/faceThumbnails/$imageFilename";
  }

  Widget _faces(ContactResponse response) {
    return Container(
      height: 88,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
        scrollDirection: Axis.horizontal,
        itemCount: response.data.faces.list.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              _thumbnailImageUrl(response.data.faces.list.elementAt(index).thumbnailImageFilename),
              width: 80,
              height: 80,
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar(ContactResponse response) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _thumbnailImageUrl(response.data.faces.avatar),
              height: 120,
              width: 120,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    response.data.name.first,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff37474f),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    response.data.name.last,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff37474f),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//  Widget _sectionTitle(String title) {
//    return Container(
//      height: 32,
//      child: Align(
//        alignment: Alignment.centerLeft,
//        child: Text(
//          title,
//          style: const TextStyle(
//            fontWeight: FontWeight.w500,
//            color: Color(0xff90a4ae),
//          ),
//        ),
//      ),
//    );
//  }

//  Widget _item(String key, String value) {
//    return Container(
//      height: 32,
//      padding: const EdgeInsets.only(left: 16),
//      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          Expanded(
//            flex: 2,
//            child: Text(
//              key,
//              style: TextStyle(
//                fontSize: 16,
//              ),
//            ),
//          ),
//          Expanded(
//            flex: 4,
//            child: Text(
//              value,
//              style: TextStyle(
//                fontSize: 16,
//                color: Color(0xff607d8b),
//              ),
//            ),
//          ),
//          Expanded(
//            flex: 1,
//            child: Text(""),
//          ),
//        ],
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact Detail"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: _getContact(),
          builder: (context, AsyncSnapshot<ContactResponse> snapshot) {
            if (snapshot.hasData) {
              ContactResponse response = snapshot.data;
              return Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _avatar(response),
                      Divider(),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            SectionTitle(title: "Occupation"),
                            ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                DisplayItem(name: "Company", value: "Google"),
                                DisplayItem(
                                    name: "Position", value: "Developer"),
                              ],
                            ),
                            SectionTitle(title: "Emails"),
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => DisplayItem(
                                name:
                                    response.data.emails.elementAt(index).label,
                                value: response.data.emails
                                    .elementAt(index)
                                    .address,
                              ),
                              itemCount: response.data.emails.length,
                            ),
                            SectionTitle(title: "Phones"),
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => DisplayItem(
                                name:
                                    response.data.phones.elementAt(index).label,
                                value: response.data.phones
                                    .elementAt(index)
                                    .number,
                              ),
                              itemCount: response.data.phones.length,
                            ),
                            SectionTitle(title: "Social Profile"),
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => DisplayItem(
                                name: response.data.socials
                                    .elementAt(index)
                                    .platform,
                                value: response.data.socials
                                    .elementAt(index)
                                    .username,
                              ),
                              itemCount: response.data.socials.length,
                            ),
                            Divider(),
                            SectionTitle(title: "Related Photos"),
                            _faces(response),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }

//  List<Widget> w = [
//    Padding(
//      padding: const EdgeInsets.only(left: 16),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Expanded(
//            flex: 2,
//            child: Text('Company'),
//          ),
//          Expanded(
//            flex: 4,
//            child: TextField(
//              decoration: InputDecoration(
//                isDense: true,
//              ),
//            ),
//          ),
//          Expanded(
//            flex: 1,
//            child: IconButton(
//              icon: Icon(Icons.add_circle),
//              onPressed: () => print("asdfsa"),
//            ),
//          ),
//        ],
//      ),
//    ),
//    Padding(
//      padding: const EdgeInsets.only(left: 16),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Expanded(
//            flex: 2,
//            child: Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 8),
//              child: SimpleAutoCompleteTextField(
//                suggestions: ["aaaa", "bbbb", "cc", "dddd"],
//                decoration: InputDecoration(
//                  isDense: true,
//                ),
//              ),
//            ),
//          ),
//          Expanded(
//            flex: 4,
//            child: TextField(
//              decoration: InputDecoration(
//                isDense: true,
//              ),
//            ),
//          ),
//          Expanded(
//            flex: 1,
//            child: IconButton(
//              icon: Icon(Icons.add_circle),
//              onPressed: () => print("asdfsa"),
//            ),
//          ),
//        ],
//      ),
//    ),
//  ];
}

class Section extends StatelessWidget {
//  final String title;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DisplayItem extends StatelessWidget {
  final String name;
  final String value;

  DisplayItem({this.name, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff607d8b),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(""),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff90a4ae),
          ),
        ),
      ),
    );
  }
}
