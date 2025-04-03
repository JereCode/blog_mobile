import 'package:blog_mobile/Business/models/Category.dart';
import '../../Business/models/Article.dart';

class ListArticleState {
  List<Article>? articles;
  List<Category>? categories;
  int? page;
  String? recherche;
  int? categorieSelectionee;
  bool? isLoading;

  ListArticleState({
    this.articles,
    this.categories,
    this.page,
    this.recherche,
    this.categorieSelectionee,
    this.isLoading,
  });

  ListArticleState copyWith({
    List<Article>? articles,
    List<Category>? categories,
    int? page,
    String? recherche,
    int? categorieSelectionee,
    bool? isLoading,
  }) =>
      ListArticleState(
        articles: articles ?? this.articles,
        categories: categories ?? this.categories,
        page: page ?? this.page,
        recherche: recherche ?? this.recherche,
        categorieSelectionee: categorieSelectionee ?? this.categorieSelectionee,
        isLoading: isLoading ?? this.isLoading,
      );
}