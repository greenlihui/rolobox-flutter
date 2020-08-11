import 'dart:convert';

class UserResponse1 {
  Data data;

  UserResponse1({
    this.data,
  });

  factory UserResponse1.fromRawJson(String str) => UserResponse1.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponse1.fromJson(Map<String, dynamic> json) => UserResponse1(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Status status;
  String id;
  String email;
  Profile profile;

  Data({
    this.status,
    this.id,
    this.email,
    this.profile,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    id: json["_id"] == null ? null : json["_id"],
    email: json["email"] == null ? null : json["email"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status.toJson(),
    "_id": id == null ? null : id,
    "email": email == null ? null : email,
    "profile": profile == null ? null : profile.toJson(),
  };
}

class Profile {
  Name name;
  Occupation occupation;
  Faces faces;
  String id;
  List<Email> emails;
  List<Phone> phones;
  List<Social> socials;
  String profileId;

  Profile({
    this.name,
    this.occupation,
    this.faces,
    this.id,
    this.emails,
    this.phones,
    this.socials,
    this.profileId,
  });

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    occupation: json["occupation"] == null ? null : Occupation.fromJson(json["occupation"]),
    faces: json["faces"] == null ? null : Faces.fromJson(json["faces"]),
    id: json["_id"] == null ? null : json["_id"],
    emails: json["emails"] == null ? null : List<Email>.from(json["emails"].map((x) => Email.fromJson(x))),
    phones: json["phones"] == null ? null : List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))),
    socials: json["socials"] == null ? null : List<Social>.from(json["socials"].map((x) => Social.fromJson(x))),
    profileId: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name.toJson(),
    "occupation": occupation == null ? null : occupation.toJson(),
    "faces": faces == null ? null : faces.toJson(),
    "_id": id == null ? null : id,
    "emails": emails == null ? null : List<dynamic>.from(emails.map((x) => x.toJson())),
    "phones": phones == null ? null : List<dynamic>.from(phones.map((x) => x.toJson())),
    "socials": socials == null ? null : List<dynamic>.from(socials.map((x) => x.toJson())),
    "id": profileId == null ? null : profileId,
  };
}

class Email {
  String id;
  String label;
  String address;

  Email({
    this.id,
    this.label,
    this.address,
  });

  factory Email.fromRawJson(String str) => Email.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Email.fromJson(Map<String, dynamic> json) => Email(
    id: json["_id"] == null ? null : json["_id"],
    label: json["label"] == null ? null : json["label"],
    address: json["address"] == null ? null : json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "label": label == null ? null : label,
    "address": address == null ? null : address,
  };
}

class Faces {
  String avatar;
  List<ListElement> list;

  Faces({
    this.avatar,
    this.list,
  });

  factory Faces.fromRawJson(String str) => Faces.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Faces.fromJson(Map<String, dynamic> json) => Faces(
    avatar: json["avatar"] == null ? null : json["avatar"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar == null ? null : avatar,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  String id;
  String awsFaceId;
  String awsImageId;
  String awsCollectionId;
  String thumbnailImageFilename;
  Details details;

  ListElement({
    this.id,
    this.awsFaceId,
    this.awsImageId,
    this.awsCollectionId,
    this.thumbnailImageFilename,
    this.details,
  });

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"] == null ? null : json["_id"],
    awsFaceId: json["awsFaceId"] == null ? null : json["awsFaceId"],
    awsImageId: json["awsImageId"] == null ? null : json["awsImageId"],
    awsCollectionId: json["awsCollectionId"] == null ? null : json["awsCollectionId"],
    thumbnailImageFilename: json["thumbnailImageFilename"] == null ? null : json["thumbnailImageFilename"],
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "awsFaceId": awsFaceId == null ? null : awsFaceId,
    "awsImageId": awsImageId == null ? null : awsImageId,
    "awsCollectionId": awsCollectionId == null ? null : awsCollectionId,
    "thumbnailImageFilename": thumbnailImageFilename == null ? null : thumbnailImageFilename,
    "details": details == null ? null : details.toJson(),
  };
}

class Details {
  BoundingBox boundingBox;
  AgeRange ageRange;
  Beard smile;
  Beard eyeglasses;
  Beard sunglasses;
  Gender gender;
  Beard beard;
  Beard mustache;
  Beard eyesOpen;
  Beard mouthOpen;
  List<Emotion> emotions;
  List<Landmark> landmarks;
  Pose pose;
  Quality quality;
  double confidence;

  Details({
    this.boundingBox,
    this.ageRange,
    this.smile,
    this.eyeglasses,
    this.sunglasses,
    this.gender,
    this.beard,
    this.mustache,
    this.eyesOpen,
    this.mouthOpen,
    this.emotions,
    this.landmarks,
    this.pose,
    this.quality,
    this.confidence,
  });

  factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    boundingBox: json["BoundingBox"] == null ? null : BoundingBox.fromJson(json["BoundingBox"]),
    ageRange: json["AgeRange"] == null ? null : AgeRange.fromJson(json["AgeRange"]),
    smile: json["Smile"] == null ? null : Beard.fromJson(json["Smile"]),
    eyeglasses: json["Eyeglasses"] == null ? null : Beard.fromJson(json["Eyeglasses"]),
    sunglasses: json["Sunglasses"] == null ? null : Beard.fromJson(json["Sunglasses"]),
    gender: json["Gender"] == null ? null : Gender.fromJson(json["Gender"]),
    beard: json["Beard"] == null ? null : Beard.fromJson(json["Beard"]),
    mustache: json["Mustache"] == null ? null : Beard.fromJson(json["Mustache"]),
    eyesOpen: json["EyesOpen"] == null ? null : Beard.fromJson(json["EyesOpen"]),
    mouthOpen: json["MouthOpen"] == null ? null : Beard.fromJson(json["MouthOpen"]),
    emotions: json["Emotions"] == null ? null : List<Emotion>.from(json["Emotions"].map((x) => Emotion.fromJson(x))),
    landmarks: json["Landmarks"] == null ? null : List<Landmark>.from(json["Landmarks"].map((x) => Landmark.fromJson(x))),
    pose: json["Pose"] == null ? null : Pose.fromJson(json["Pose"]),
    quality: json["Quality"] == null ? null : Quality.fromJson(json["Quality"]),
    confidence: json["Confidence"] == null ? null : json["Confidence"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "BoundingBox": boundingBox == null ? null : boundingBox.toJson(),
    "AgeRange": ageRange == null ? null : ageRange.toJson(),
    "Smile": smile == null ? null : smile.toJson(),
    "Eyeglasses": eyeglasses == null ? null : eyeglasses.toJson(),
    "Sunglasses": sunglasses == null ? null : sunglasses.toJson(),
    "Gender": gender == null ? null : gender.toJson(),
    "Beard": beard == null ? null : beard.toJson(),
    "Mustache": mustache == null ? null : mustache.toJson(),
    "EyesOpen": eyesOpen == null ? null : eyesOpen.toJson(),
    "MouthOpen": mouthOpen == null ? null : mouthOpen.toJson(),
    "Emotions": emotions == null ? null : List<dynamic>.from(emotions.map((x) => x.toJson())),
    "Landmarks": landmarks == null ? null : List<dynamic>.from(landmarks.map((x) => x.toJson())),
    "Pose": pose == null ? null : pose.toJson(),
    "Quality": quality == null ? null : quality.toJson(),
    "Confidence": confidence == null ? null : confidence,
  };
}

class AgeRange {
  int low;
  int high;

  AgeRange({
    this.low,
    this.high,
  });

  factory AgeRange.fromRawJson(String str) => AgeRange.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgeRange.fromJson(Map<String, dynamic> json) => AgeRange(
    low: json["Low"] == null ? null : json["Low"],
    high: json["High"] == null ? null : json["High"],
  );

  Map<String, dynamic> toJson() => {
    "Low": low == null ? null : low,
    "High": high == null ? null : high,
  };
}

class Beard {
  bool value;
  double confidence;

  Beard({
    this.value,
    this.confidence,
  });

  factory Beard.fromRawJson(String str) => Beard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Beard.fromJson(Map<String, dynamic> json) => Beard(
    value: json["Value"] == null ? null : json["Value"],
    confidence: json["Confidence"] == null ? null : json["Confidence"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Value": value == null ? null : value,
    "Confidence": confidence == null ? null : confidence,
  };
}

class BoundingBox {
  double width;
  double height;
  double left;
  double top;

  BoundingBox({
    this.width,
    this.height,
    this.left,
    this.top,
  });

  factory BoundingBox.fromRawJson(String str) => BoundingBox.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BoundingBox.fromJson(Map<String, dynamic> json) => BoundingBox(
    width: json["Width"] == null ? null : json["Width"].toDouble(),
    height: json["Height"] == null ? null : json["Height"].toDouble(),
    left: json["Left"] == null ? null : json["Left"].toDouble(),
    top: json["Top"] == null ? null : json["Top"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Width": width == null ? null : width,
    "Height": height == null ? null : height,
    "Left": left == null ? null : left,
    "Top": top == null ? null : top,
  };
}

class Emotion {
  String type;
  double confidence;

  Emotion({
    this.type,
    this.confidence,
  });

  factory Emotion.fromRawJson(String str) => Emotion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Emotion.fromJson(Map<String, dynamic> json) => Emotion(
    type: json["Type"] == null ? null : json["Type"],
    confidence: json["Confidence"] == null ? null : json["Confidence"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Type": type == null ? null : type,
    "Confidence": confidence == null ? null : confidence,
  };
}

class Gender {
  String value;
  double confidence;

  Gender({
    this.value,
    this.confidence,
  });

  factory Gender.fromRawJson(String str) => Gender.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
    value: json["Value"] == null ? null : json["Value"],
    confidence: json["Confidence"] == null ? null : json["Confidence"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Value": value == null ? null : value,
    "Confidence": confidence == null ? null : confidence,
  };
}

class Landmark {
  String type;
  double x;
  double y;

  Landmark({
    this.type,
    this.x,
    this.y,
  });

  factory Landmark.fromRawJson(String str) => Landmark.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Landmark.fromJson(Map<String, dynamic> json) => Landmark(
    type: json["Type"] == null ? null : json["Type"],
    x: json["X"] == null ? null : json["X"].toDouble(),
    y: json["Y"] == null ? null : json["Y"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Type": type == null ? null : type,
    "X": x == null ? null : x,
    "Y": y == null ? null : y,
  };
}

class Pose {
  double roll;
  double yaw;
  double pitch;

  Pose({
    this.roll,
    this.yaw,
    this.pitch,
  });

  factory Pose.fromRawJson(String str) => Pose.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pose.fromJson(Map<String, dynamic> json) => Pose(
    roll: json["Roll"] == null ? null : json["Roll"].toDouble(),
    yaw: json["Yaw"] == null ? null : json["Yaw"].toDouble(),
    pitch: json["Pitch"] == null ? null : json["Pitch"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Roll": roll == null ? null : roll,
    "Yaw": yaw == null ? null : yaw,
    "Pitch": pitch == null ? null : pitch,
  };
}

class Quality {
  double brightness;
  double sharpness;

  Quality({
    this.brightness,
    this.sharpness,
  });

  factory Quality.fromRawJson(String str) => Quality.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quality.fromJson(Map<String, dynamic> json) => Quality(
    brightness: json["Brightness"] == null ? null : json["Brightness"].toDouble(),
    sharpness: json["Sharpness"] == null ? null : json["Sharpness"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Brightness": brightness == null ? null : brightness,
    "Sharpness": sharpness == null ? null : sharpness,
  };
}

class Name {
  String first;
  String last;
  String full;

  Name({
    this.first,
    this.last,
    this.full,
  });

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    first: json["first"] == null ? null : json["first"],
    last: json["last"] == null ? null : json["last"],
    full: json["full"] == null ? null : json["full"],
  );

  Map<String, dynamic> toJson() => {
    "first": first == null ? null : first,
    "last": last == null ? null : last,
    "full": full == null ? null : full,
  };
}

class Occupation {
  String company;
  String position;

  Occupation({
    this.company,
    this.position,
  });

  factory Occupation.fromRawJson(String str) => Occupation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
    company: json["company"] == null ? null : json["company"],
    position: json["position"] == null ? null : json["position"],
  );

  Map<String, dynamic> toJson() => {
    "company": company == null ? null : company,
    "position": position == null ? null : position,
  };
}

class Phone {
  String id;
  String label;
  String number;

  Phone({
    this.id,
    this.label,
    this.number,
  });

  factory Phone.fromRawJson(String str) => Phone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
    id: json["_id"] == null ? null : json["_id"],
    label: json["label"] == null ? null : json["label"],
    number: json["number"] == null ? null : json["number"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "label": label == null ? null : label,
    "number": number == null ? null : number,
  };
}

class Social {
  String id;
  String platform;
  String username;

  Social({
    this.id,
    this.platform,
    this.username,
  });

  factory Social.fromRawJson(String str) => Social.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    id: json["_id"] == null ? null : json["_id"],
    platform: json["platform"] == null ? null : json["platform"],
    username: json["username"] == null ? null : json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "platform": platform == null ? null : platform,
    "username": username == null ? null : username,
  };
}

class Status {
  bool firstSignedIn;
  bool verified;
  bool locked;
  bool closed;

  Status({
    this.firstSignedIn,
    this.verified,
    this.locked,
    this.closed,
  });

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    firstSignedIn: json["firstSignedIn"] == null ? null : json["firstSignedIn"],
    verified: json["verified"] == null ? null : json["verified"],
    locked: json["locked"] == null ? null : json["locked"],
    closed: json["closed"] == null ? null : json["closed"],
  );

  Map<String, dynamic> toJson() => {
    "firstSignedIn": firstSignedIn == null ? null : firstSignedIn,
    "verified": verified == null ? null : verified,
    "locked": locked == null ? null : locked,
    "closed": closed == null ? null : closed,
  };
}
