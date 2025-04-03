import 'package:blog_mobile/Business/models/Authentification.dart';
import 'package:blog_mobile/Business/models/Article.dart';
import 'package:blog_mobile/Business/models/Category.dart';

import '../models/User.dart';

abstract class BloNetworkService {
  Future<User> authentifier(Authentication data);
  Future<Article> recupererArticle(int articleId);
  Future<List<Category>> recupererCategories();
}