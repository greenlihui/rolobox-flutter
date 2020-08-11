import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/main.dart';
import 'package:rolobox/models/group_contact_response.dart';
import 'package:rolobox/shared/http_utils.dart';

class PhoneContactsWidget extends StatefulWidget {
  String groupId;

  PhoneContactsWidget({Key key, this.groupId}) : super(key: key);

  @override
  _PhoneContactsWidgetState createState() => _PhoneContactsWidgetState();
}

class _PhoneContactsWidgetState extends State<PhoneContactsWidget> {
  List<Contact> _contacts;

  Future<void> refreshContacts() async {
    // Load without thumbnails initially.
    var contacts = (await ContactsService
        .getContacts(withThumbnails: false))
        .toList();
//      var contacts = (await ContactsService.getContactsForPhone("8554964652"))
//          .toList();
    setState(() {
      _contacts = contacts;
    });

    // Lazy load thumbnails after rendering initial contacts.
    for (final contact in contacts) {
      ContactsService.getAvatar(contact).then((avatar) {
        if (avatar == null) return; // Don't redraw if no change.
        setState(() => contact.avatar = avatar);
      });
    }
  }

  _uploadContacts() {
    List<Datum> transformedContacts = _contacts.map((contact) => Datum(
      group: widget.groupId,
      name: Name(first: contact.givenName, last: contact.familyName),
      occupation: Occupation(company: contact.company, position: contact.jobTitle),
      emails: contact.emails.map((email) => Email(label: email.label, address: email.value)).toList(),
      phones: contact.phones.map((phone) => Phone(label: phone.label, number: phone.value)).toList(),
    )).toList();
    transformedContacts.forEach((contact) {
      String userId = Provider.of<User>(context, listen: false).userData.data.id;
      HttpUtil.getInstance().post(
        "/users/$userId/groups/${widget.groupId}/contacts",
        data: contact
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phone Contacts',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sync, color: Colors.white
              ,),
            onPressed: _uploadContacts,
          )
        ],
      ),
      body: SafeArea(
        child: _contacts != null
            ? ListView.builder(
          itemCount: _contacts?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            Contact c = _contacts?.elementAt(index);
            return ListTile(
              leading: (c.avatar != null && c.avatar.length > 0)
                  ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                  : CircleAvatar(child: Text(c.initials())),
              title: Text(c.displayName ?? ""),
            );
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
