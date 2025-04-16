import 'package:blog_mobile/Business/models/Authentification.dart';
import 'package:blog_mobile/Business/models/Article.dart';
import 'package:blog_mobile/Business/models/Category.dart';
import 'package:blog_mobile/Business/models/ModifierArticle.dart';
import 'package:blog_mobile/Business/models/Tag.dart';

import '../models/User.dart';

abstract class BloNetworkService {
  Future<User> authentifier(Authentication data);
  Future<Article> recupererArticle(int articleId, String token);
  Future<List<Category>> recupererCategories();
  Future<List<Tag>> recupererTags();
  Future<Article> modifierArticle(int articleId ,ModifierArticle data, String token);
}