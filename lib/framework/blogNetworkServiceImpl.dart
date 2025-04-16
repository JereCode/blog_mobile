
import 'dart:convert';

import 'package:blog_mobile/Business/models/Article.dart';
import 'package:blog_mobile/Business/models/Authentification.dart';
import 'package:blog_mobile/Business/models/Category.dart';
import 'package:blog_mobile/Business/models/ModifierArticle.dart';
import 'package:blog_mobile/Business/models/Tag.dart';
import 'package:blog_mobile/Business/models/User.dart';
import '../Business/services/blogNetworkService.dart';
import 'package:http/http.dart' as http;

class BloNetworkServiceImpl implements BloNetworkService{
  String baseUrl;

  BloNetworkServiceImpl({required this.baseUrl});

  @override
  Future<User> authentifier(Authentication data) async{
    var url = Uri.parse("$baseUrl/api/login");
    var body = jsonEncode(data.toJson());
    var response = await http.post(
        url,
      body: body,
      headers: {"content-type":"application/json"}
    );
    var resultat = jsonDecode(response.body) as Map; //Map
    var codes = [200, 201];
    if (!codes.contains(response.statusCode)){
      var error = resultat["error"];
      throw Exception(error);
    }

    var user = User.fromMap(resultat['data']);

    return user;
  }

  @override
  Future<Article> recupererArticle(int articleId, String token) async {
    var url = Uri.parse("$baseUrl/api/articles/$articleId");

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json",
        "Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      var resultat = jsonDecode(response.body) as Map<String, dynamic>;
      return Article.fromMap(resultat['data']); // Instanciation de l'Article
    } else {
      var erreur = jsonDecode(response.body)['error'] ?? "Erreur inconnue";
      throw Exception(erreur);
    }
  }

  @override
  Future<List<Category>> recupererCategories() async{
    var url = Uri.parse("$baseUrl/api/categories/");

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var resultat = jsonDecode(response.body); // Ne pas caster en `Map`, c'est une `List`

      if (resultat is List) {
        return resultat.map((categorie) => Category.fromMap(categorie)).toList();
      } else {
        throw Exception("Format de réponse invalide : attendu une liste.");
      }
    } else {
      var erreur = jsonDecode(response.body)['error'] ?? "Erreur inconnue";
      throw Exception(erreur);
    }
  }

  @override
  Future<Article> modifierArticle(int articleId,ModifierArticle data, String token) async{
    var url = Uri.parse("$baseUrl/api/articles/$articleId");
    print("url $url");
    var body = jsonEncode(data.toMap());
    var response = await http.put(
        url,
        body: body,
        headers: {"content-type":"application/json",
        "Authorization": "Bearer $token"
        }
    );
    print("resultat ${response.body}");

    var resultat = jsonDecode(response.body) as Map; //Map
    var codes = [200, 201];
    if (!codes.contains(response.statusCode)){
      var error = resultat["error"];
      throw Exception(error);
    }

    var articleModif = Article.fromMap(resultat['data']);

    return articleModif;
  }

  @override
  Future<List<Tag>> recupererTags() async{
    var url = Uri.parse("$baseUrl/api/tags/");

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var resultat = jsonDecode(response.body); // Ne pas caster en `Map`, c'est une `List`

      if (resultat is List) {
        return resultat.map((tag) => Tag.fromMap(tag)).toList();
      } else {
        throw Exception("Format de réponse invalide : attendu une liste.");
      }
    } else {
      var erreur = jsonDecode(response.body)['error'] ?? "Erreur inconnue";
      throw Exception(erreur);
    }
  }
}

void main() async{
  var categorie = [1];
  var tag = [1];
  int articleId=11;
  var token = "1|J5atvH7P7IP4qzeYc86Ycq5mL6P3bloZ3PgkDvD8d06e09d1";
  var formulaire = ModifierArticle(title: "Jules", photo: "http://irfireufeuferf.jpg", content: "Popostar et tendance", categories: categorie, tags: tag);
  var service = BloNetworkServiceImpl(baseUrl: "http://10.20.20.208:8000");
  // var categories = await service.recupererCategories();
  // var tags = await service.recupererTags();
  //var article = await service.recupererArticle(articleId, token);
  //print(article.toMap());

  var  resultatModification= await service.modifierArticle(articleId, formulaire, token);
  print(resultatModification.toMap());
}