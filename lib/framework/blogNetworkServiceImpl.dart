
import 'dart:convert';

import 'package:blog_mobile/Business/models/Article.dart';
import 'package:blog_mobile/Business/models/Authentification.dart';
import 'package:blog_mobile/Business/models/Category.dart';
import 'package:blog_mobile/Business/models/User.dart';
import '../Business/services/blogNetworkService.dart';
import 'package:http/http.dart' as http;

class BloNetworkServiceImpl implements BloNetworkService{
  @override
  Future<User> authentifier(Authentication data) async{
    var url = Uri.parse("http://localhost:8000/api/login");
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
  Future<Article> recupererArticle(int articleId) async {
    var url = Uri.parse("http://localhost:8000/api/articles/$articleId");

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
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
    var url = Uri.parse("http://localhost:8000/api/categories/");

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
}

void main() async{
  var formulaire = Authentication(email: "ado@gmail.com", password: "ado123");
  var service = BloNetworkServiceImpl();
  var user = await service.recupererArticle(1);


  print(user.toMap());
}