// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifieldAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifieldAt,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    DateTime? emailVerifieldAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerifieldAt: emailVerifieldAt ?? this.emailVerifieldAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        token: token ?? this.token,
      );

  factory User.fromMap(Map json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifieldAt: json["email_verifield_at"] == null ? null : DateTime.parse(json["email_verifield_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verifield_at": emailVerifieldAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "token": token,
  };
}