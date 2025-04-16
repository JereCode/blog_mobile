// To parse this JSON data, do
//
//     final tag = tagFromMap(jsonString);

import 'dart:convert';

Tag tagFromMap(String str) => Tag.fromMap(json.decode(str));

String tagToMap(Tag data) => json.encode(data.toMap());

class Tag {
  int? id;
  String? name;
  String? description;

  Tag({
    this.id,
    this.name,
    this.description,
  });

  Tag copyWith({
    int? id,
    String? name,
    String? description,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
  };
}