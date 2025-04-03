import 'dart:convert';

Authentication authenticationFromJson(String str) => Authentication.fromJson(json.decode(str));
String authenticationToJson(Authentication data) => json.encode(data.toJson());

class Authentication {
  String email;
  String password;

  Authentication({
    required this.email,
    required this.password,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}