// To parse this JSON data, do
//
//     final modifierArticle = modifierArticleFromMap(jsonString);
import 'dart:convert';

ModifierArticle modifierArticleFromMap(String str) =>
    ModifierArticle.fromMap(json.decode(str));

String modifierArticleToMap(ModifierArticle data) =>
    json.encode(data.toMap());

class ModifierArticle {
  String? title;
  String? photo;
  String? content;
  List<int>? categories;
  List<int>? tags;

  ModifierArticle({
    this.title,
    this.photo,
    this.content,
    this.categories,
    this.tags,
  });

  ModifierArticle copyWith({
    String? title,
    String? photo,
    String? content,
    List<int>? categories,
    List<int>? tags,
  }) =>
      ModifierArticle(
        title: title ?? this.title,
        photo: photo ?? this.photo,
        content: content ?? this.content,
        categories: categories ?? this.categories,
        tags: tags ?? this.tags,
      );

  factory ModifierArticle.fromMap(Map<String, dynamic> json) => ModifierArticle(
    title: json["title"],
    photo: json["photo"],
    content: json["content"],
    categories: json["categories"] == null
        ? []
        : List<int>.from(json["categories"].map((x) => x)),
    tags: json["tags"] == null
        ? []
        : List<int>.from(json["tags"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "photo": photo,
    "content": content,
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x)),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}