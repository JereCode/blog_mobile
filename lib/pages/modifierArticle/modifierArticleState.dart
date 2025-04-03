import 'dart:convert';

import '../../Business/models/Article.dart';
import '../../Business/models/Category.dart';

class ModifierArticleState {
  Article? article;
  List<Category>? categories;
  bool? isLoading;

  ModifierArticleState({
    this.article,
    this.categories,
    this.isLoading,
  });

  ModifierArticleState copyWith({
    Article? article,
    List<Category>? categories,
    bool? isLoading,
  }) =>
      ModifierArticleState(
        article: article ?? this.article,
        categories: categories ?? this.categories,
        isLoading: isLoading ?? this.isLoading,
      );
}