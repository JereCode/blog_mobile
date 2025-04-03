import 'package:blog_mobile/Business/models/Category.dart';

class ModifierArticle {
  String? titre;
  String? image;
  String? auteur;
  String? recherche;
  List<Category>? categorie;

  ModifierArticle({
    this.titre,
    this.image,
    this.auteur,
    this.recherche,
    this.categorie,
  });

  ModifierArticle copyWith({
    String? titre,
    String? image,
    String? auteur,
    String? recherche,
    List<Category>? categorie,
  }) =>
      ModifierArticle(
        titre: titre ?? this.titre,
        image: image ?? this.image,
        auteur: auteur ?? this.auteur,
        recherche: recherche ?? this.recherche,
        categorie: categorie ?? this.categorie,
      );
}