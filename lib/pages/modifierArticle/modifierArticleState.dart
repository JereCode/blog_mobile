import 'dart:convert';

import 'package:blog_mobile/Business/models/Tag.dart';

import '../../Business/models/Article.dart';
import '../../Business/models/Category.dart';

class ModifierArticleState {
  Article? article;
  List<Category>? categories;
  List<Tag>? tags;
  bool? isLoading;

  ModifierArticleState({
    this.article,
    this.categories,
    this.tags,
    this.isLoading,
  });

  ModifierArticleState copyWith({
    Article? article,
    List<Category>? categories,
    List<Tag>? tags,
    bool? isLoading,
  }) =>
      ModifierArticleState(
        article: article ?? this.article,
        categories: categories ?? this.categories,
        tags: tags ?? this.tags,
        isLoading: isLoading ?? this.isLoading,
      );
}