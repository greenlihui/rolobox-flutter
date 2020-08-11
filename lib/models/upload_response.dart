import 'dart:convert';

class UploadResponse {
  Data data;

  UploadResponse({
    this.data,
  });

  factory UploadResponse.fromRawJson(String str) => UploadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  String filename;

  Data({
    this.filename,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    filename: json["filename"] == null ? null : json["filename"],
  );

  Map<String, dynamic> toJson() => {
    "filename": filename == null ? null : filename,
  };
}