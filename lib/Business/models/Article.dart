// To parse this JSON data, do
//
//     final article = articleFromMap(jsonString);

import 'dart:convert';

import 'package:blog_mobile/Business/models/Category.dart';
import 'package:blog_mobile/Business/models/Tag.dart';

Article articleFromMap(String str) => Article.fromMap(json.decode(str));

String articleToMap(Article data) => json.encode(data.toMap());

class Article {
  int? id;
  String? title;
  String? slug;
  String? photo;
  Auteur? auteur;
  String? content;
  int? nbrComment;
  int? nbrVue;
  int? nbLikes;
  List<Category>? category;
  List<Tag>? tags;
  String? dateCreation;
  DateTime? lastModif;

  Article({
    this.id,
    this.title,
    this.slug,
    this.photo,
    this.auteur,
    this.content,
    this.nbrComment,
    this.nbrVue,
    this.nbLikes,
    this.category,
    this.tags,
    this.dateCreation,
    this.lastModif,
  });

  Article copyWith({
    int? id,
    String? title,
    String? slug,
    String? photo,
    Auteur? auteur,
    String? content,
    int? nbrComment,
    int? nbrVue,
    int? nbLikes,
    List<Category>? category,
    List<Tag>? tags,
    String? dateCreation,
    DateTime? lastModif,
  }) =>
      Article(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        photo: photo ?? this.photo,
        auteur: auteur ?? this.auteur,
        content: content ?? this.content,
        nbrComment: nbrComment ?? this.nbrComment,
        nbrVue: nbrVue ?? this.nbrVue,
        nbLikes: nbLikes ?? this.nbLikes,
        category: category ?? this.category,
        tags: tags ?? this.tags,
        dateCreation: dateCreation ?? this.dateCreation,
        lastModif: lastModif ?? this.lastModif,
      );

  factory Article.fromMap(Map<String, dynamic> json) => Article(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    photo: json["photo"],
    auteur: json["auteur"] == null ? null : Auteur.fromMap(json["auteur"]),
    content: json["content"],
    nbrComment: json["nbr_comment"],
    nbrVue: json["nbr_vue"],
    nbLikes: json["nb_likes"],
    category: json["category"] == null ? [] : List<Category>.from(json["category"].map((x) => Category.fromMap(x))),
    tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"].map((x) => Tag.fromMap(x))),
    dateCreation: json["date_creation"],
    lastModif: json["last_modif"] == null ? null : DateTime.parse(json["last_modif"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "slug": slug,
    "photo": photo,
    "auteur": auteur?.toMap(),
    "content": content,
    "nbr_comment": nbrComment,
    "nbr_vue": nbrVue,
    "nb_likes": nbLikes,
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "date_creation": dateCreation,
    "last_modif": lastModif?.toIso8601String(),
  };
}

class Auteur {
  int? id;
  String? name;

  Auteur({
    this.id,
    this.name,
  });

  Auteur copyWith({
    int? id,
    String? name,
  }) =>
      Auteur(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Auteur.fromMap(Map<String, dynamic> json) => Auteur(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
