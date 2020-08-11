
class Contact {
  String id;
  dynamic group;
  dynamic faces;
  Name name;
  List<EmailItem> emails;
  List<PhoneItem> phones;
  List<SocialItem> socials;
  Occupation occupation;

  Contact({this.id, this.group, this.faces, this.name, this.emails, this.phones,
    this.socials, this.occupation,});

  factory Contact.fromJson(Map<String, dynamic> parsedJson) {
    return Contact(
      id: parsedJson['_id'],
      group: parsedJson['group'],
      faces: parsedJson['faces'],
      name: parsedJson['name'],
      emails: parsedJson['emails'],
      phones: parsedJson['phones'],
      socials: parsedJson['socials'],
      occupation: parsedJson['occupation'],
    );
  }
}

class Name {
  String first;
  String last;

  Name({
    this.first,
    this.last,
  });

  factory Name.fromJson(Map<String, dynamic> parsedJson) {
    return Name(
      first: parsedJson['first'],
      last: parsedJson['last'],
    );
  }
}

class Occupation {
  String company;
  String position;

  Occupation({
    this.company,
    this.position,
  });

  factory Occupation.fromJson(Map<String, dynamic> parsedJson) {
    return Occupation(
      company: parsedJson['company'],
      position: parsedJson['position'],
    );
  }
}

class EmailItem {
  String label;
  String address;

  EmailItem({
    this.label,
    this.address,
  });

  factory EmailItem.fromJson(Map<String, dynamic> parsedJson) {
    return EmailItem(
      label: parsedJson['label'],
      address: parsedJson['address'],
    );
  }
}

class PhoneItem {
  String label;
  String number;

  PhoneItem({
    this.label,
    this.number,
  });

  factory PhoneItem.fromJson(Map<String, dynamic> parsedJson) {
    return PhoneItem(
      label: parsedJson['label'],
      number: parsedJson['number'],
    );
  }
}

class SocialItem {
  String platform;
  String username;

  SocialItem({
    this.platform,
    this.username,
  });

  factory SocialItem.fromJson(Map<String, dynamic> parsedJson) {
    return SocialItem(
      platform: parsedJson['platform'],
      username: parsedJson['username'],
    );
  }
}
