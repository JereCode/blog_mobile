import 'package:blog_mobile/pages/listArticles/listArticlesState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListArticlesCtrl extends StateNotifier<ListArticleState>{
  ListArticlesCtrl():super(ListArticleState()){
    //init
  }
  Future<void> recupererArticles() async{}
  Future<void> rechercher(String texte) async{}
  Future<void> liker(int articleId) async{}
  Future<void> partager(int articleId) async{}
  Future<void> filtrerParCategorie(int categorieId) async{}
  Future<void> trier(String colonne, String ordre) async{}
}