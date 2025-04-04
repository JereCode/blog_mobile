// To parse this JSON data, do
//
//     final modifierArticle = modifierArticleFromMap(jsonString);

import 'dart:convert';

ModifierArticle modifierArticleFromMap(String str) => ModifierArticle.fromMap(json.decode(str));

String modifierArticleToMap(ModifierArticle data) => json.encode(data.toMap());

class ModifierArticle {
  int? id;
  String? titre;
  String? image;
  String? auteur;
  List<int>? categorie;

  ModifierArticle({
    this.id,
    this.titre,
    this.image,
    this.auteur,
    this.categorie,
  });

  factory ModifierArticle.fromMap(Map<String, dynamic> json) => ModifierArticle(
    id: json["id"],
    titre: json["titre"],
    image: json["image"],
    auteur: json["auteur"],
    categorie: json["categorie"] == null ? [] : List<int>.from(json["categorie"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "titre": titre,
    "image": image,
    "auteur": auteur,
    "categorie": categorie == null ? [] : List<dynamic>.from(categorie!.map((x) => x)),
  };
}