import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/main.dart';
import 'package:rolobox/models/group_contact_response.dart';
import 'package:rolobox/models/group_response.dart' as gr;
import 'package:rolobox/models/filtered_contacts.dart' as fc;
import 'package:rolobox/routes/home/contacts/phone_contacts_widget.dart';
import 'package:rolobox/shared/http_utils.dart';
import 'package:rolobox/routes/home/contacts/add_group_widget.dart';
import 'package:rolobox/routes/home/contacts/contact_detail_widget.dart';
import 'package:rolobox/routes/home/contacts/filters_widget.dart';

enum ViewOption { list, face }
enum GroupOperation { edit, delete }

class ContactsWidget extends StatefulWidget {
  @override
  State createState() {
    return ContactsWidgetState();
  }
}

class ContactsWidgetState extends State<ContactsWidget> {
  ViewOption viewOption = ViewOption.list;
  FiltersForm _filters = FiltersForm();
  List<String> filterChips = [];
  gr.Datum ungroupedData;

  Future<gr.GroupResponse> _getGroups() async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response response =
        await HttpUtil.getInstance().get("/users/$userId/groups");
    gr.GroupResponse groups = gr.GroupResponse.fromJson(response.data);
    ungroupedData = groups.data.firstWhere((g) => g.name == "Ungrouped");
    return Future<gr.GroupResponse>.value(groups);
  }

  bool _isViewOption(ViewOption vp) {
    return viewOption == vp;
  }

  void _switchViewOption() {
    setState(() {
      viewOption =
          _isViewOption(ViewOption.list) ? ViewOption.face : ViewOption.list;
    });
  }

  Widget _listView() {
    return FutureBuilder(
      future: _getGroups(),
      builder: (ct, AsyncSnapshot<gr.GroupResponse> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.data.length,
            itemBuilder: (context, index) => GroupWidget(
              groupData: snapshot.data.data.elementAt(index),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) => Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.person_add),
                  title: new Text('Add a New Contact'),
                  onTap: () => {}),
              new ListTile(
                leading: new Icon(Icons.contact_phone),
                title: new Text('Import From Phone'),
                onTap: () {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>
                      PhoneContactsWidget(groupId: ungroupedData.datumId,)));
                },
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _openBottomSheet,
      ),
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: <Widget>[
          (_isViewOption(ViewOption.list) ?
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddGroupWidget())),
          ) : IconButton(
              icon: Icon(
                Icons.filter_list,
              ),
              onPressed: () async {
                final FiltersForm filters =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FiltersWidget(
                              filterForm: _filters,
                            )));
                _filters = filters;
              })),
          IconButton(
              icon: Icon(
                  _isViewOption(ViewOption.list) ? Icons.face : Icons.list),
              onPressed: _switchViewOption),
        ],
      ),
      body: _isViewOption(ViewOption.list)
          ? _listView()
          : ContactsFaceView(
              filters: _filters,
            ),
    );
  }
}

class ContactsFaceView extends StatelessWidget {
  final FiltersForm filters;

  ContactsFaceView({this.filters});

  List<Widget> _generateChipString() {
    List<String> chips = [];
    if (filters.genderSelected) {
      chips.add(filters.genderValue);
    }
    if (filters.ageSelected) {
      String s = "Age from " +
          filters.ageLow.toString() +
          " to " +
          filters.ageHigh.toString();
      chips.add(s);
    }
    if (filters.eyeglassesSelected) {
      String s = filters.eyeglassesValue
          ? 'Wearing Eyeglasses'
          : 'Not Wearing Eyeglasses';
      chips.add(s);
    }
    if (filters.mustacheSelected) {
      String s =
          filters.mustacheSelected ? 'Has Mustache' : 'Does not have Mustache';
      chips.add(s);
    }
    if (filters.beardSelected) {
      String s = filters.beardSelected ? 'Has Beard' : 'Does not have Beard';
      chips.add(s);
    }
    return chips
        .map((item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Chip(
              label: Text(item),
            )))
        .toList();
  }

  Future<fc.FilteredContacts> init(String userId, FiltersForm filters) async {
    Response response = await HttpUtil.getInstance().post(
        "/users/$userId/queries/filteredContacts",
        data: filters.toJson());
    return Future<fc.FilteredContacts>.value(
        fc.FilteredContacts.fromJson(response.data));
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Wrap(
            children: _generateChipString(),
          ),
          Expanded(
            child: FutureBuilder(
              future: init(userId, filters),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  fc.FilteredContacts contacts = snapshot.data;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 3 / 4),
                    itemCount: contacts.data.length,
                    itemBuilder: (context, index) {
                      return ContactFaceItem(contact: contacts.data.elementAt(index),);
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContactFaceItem extends StatefulWidget {
  final fc.Datum contact;

  ContactFaceItem({this.contact});

  @override
  _ContactFaceItemState createState() => _ContactFaceItemState();
}

class _ContactFaceItemState extends State<ContactFaceItem> {
  String _thumbnailImageUrl(imageFilename) {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    return "http://192.168.1.44:3000/api/v1/users/$userId/faceThumbnails/$imageFilename";
  }

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContactDetailWidget(
                groupId: "aassddff",
                contactId: widget.contact.id,
              ))),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, top: 8),
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: fromHex(widget.contact.group.color),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_thumbnailImageUrl(widget.contact.faces.avatar)),
                  maxRadius: 56,
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    widget.contact.name.first,
                    style:
                    const TextStyle(color: Color(0xff37474F), fontSize: 16),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.contact.name.last,
                    style:
                    const TextStyle(color: Color(0xff607D8B), fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupWidget extends StatefulWidget {
  gr.Datum groupData;

  GroupWidget({Key key, this.groupData}) : super(key: key);

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  Future<GroupContactResponse> _getContacts(String groupId) async {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    Response response = await HttpUtil.getInstance()
        .get("/users/$userId/groups/$groupId/contacts");
    return Future<GroupContactResponse>.value(
        GroupContactResponse.fromJson(response.data));
  }

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(
        Icons.label,
        color: fromHex(widget.groupData.color),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            child: Text(widget.groupData.numContacts.toString()),
            backgroundColor: Colors.teal,
            maxRadius: 12,
          ),
          PopupMenuButton<GroupOperation>(
            onSelected: (GroupOperation op) {
              print(op);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: GroupOperation.edit,
                child: Text("Edit"),
              ),
              PopupMenuItem(
                value: GroupOperation.delete,
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
      title: Text(widget.groupData.name),
      children: <Widget>[
        FutureBuilder(
          future: _getContacts(widget.groupData.id),
          builder: (BuildContext ct, AsyncSnapshot<GroupContactResponse> snap) {
            if (snap.hasData) {
              return ListView.separated(
                itemCount: snap.data.data.length,
                itemBuilder: (_, index) => ContactListItem(
                  contactData: snap.data.data.elementAt(index),
                ),
                separatorBuilder: (_, index) => Divider(
                  height: 1,
                ),
                shrinkWrap: true,
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class ContactListItem extends StatefulWidget {
  Datum contactData;

  ContactListItem({Key key, @required this.contactData}) : super(key: key);

  @override
  _ContactListItemState createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  bool onSelected = false;

  String _thumbnailImageUrl(imageFilename) {
    String userId = Provider.of<User>(context, listen: false).userData.data.id;
    return "http://192.168.1.44:3000/api/v1/users/$userId/faceThumbnails/$imageFilename";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: onSelected,
      enabled: true,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () => null,
          ),
          IconButton(
            icon: Icon(Icons.email),
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
      leading: CircleAvatar(
        radius: 24,
        backgroundImage:
            NetworkImage(_thumbnailImageUrl(widget.contactData.faces.avatar)),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContactDetailWidget(
                    groupId: "aassddff",
                    contactId: widget.contactData.id,
                  ))),
      onLongPress: () {
        setState(() {
          onSelected = !onSelected;
        });
      },
      title: Text(widget.contactData.name.full),
    );
  }
}
