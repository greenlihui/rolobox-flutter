import 'dart:convert';

class AnalysisResponse {
  List<Datum> data;

  AnalysisResponse({
    this.data,
  });

  factory AnalysisResponse.fromRawJson(String str) => AnalysisResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnalysisResponse.fromJson(Map<String, dynamic> json) => AnalysisResponse(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
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
  String thumbnailImageFilename;

  Datum({
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
    this.thumbnailImageFilename,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    thumbnailImageFilename: json["ThumbnailImageFilename"] == null ? null : json["ThumbnailImageFilename"],
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
    "ThumbnailImageFilename": thumbnailImageFilename == null ? null : thumbnailImageFilename,
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
