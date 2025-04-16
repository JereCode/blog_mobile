import 'package:blog_mobile/Business/models/Article.dart';
import 'package:blog_mobile/Business/models/Category.dart';
import 'package:blog_mobile/Business/models/ModifierArticle.dart';
import 'package:blog_mobile/pages/ModifierArticle/ModifierArticleState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




import '../../Business/services/blogNetworkService.dart';
import '../../main.dart';

class ModifierArticleCtrl extends StateNotifier<ModifierArticleState>{
  var blogNetworkService = getIt.get<BloNetworkService>();

  ModifierArticleCtrl():super(ModifierArticleState()){
    recupererCategories();
  }

  Future<Article?> recupererArticleParId(int articleId, String token) async{
    state=state.copyWith(isLoading: true);
    var res= await blogNetworkService.recupererArticle(articleId, token);
    state=state.copyWith(isLoading: false, article: res);
    return res;
  }

  Future<void> recupererCategories() async{
    state=state.copyWith(isLoading: true);
    var res= await blogNetworkService.recupererCategories();
    state=state.copyWith(isLoading: false, categories: res);
  }

  Future<void> recupererTags() async{
    state = state.copyWith(isLoading: true);
    var res = await blogNetworkService.recupererTags();
    state=state.copyWith(isLoading: false, tags: res);
  }

  Future<void> modifierArticle(int articleId, ModifierArticle data, String token) async{
    state = state.copyWith(isLoading: true);
    var res = await blogNetworkService.modifierArticle(articleId, data, token);
    state = state.copyWith(isLoading: false);

    if (res is Article){
      print('Article modifié : ${res.id}');
    } else {
      print("Erreur lors de la modification de l'article.");
    }
    }
}

final modifierArticleCtrlProvider = StateNotifierProvider<ModifierArticleCtrl, ModifierArticleState>((ref){
  return ModifierArticleCtrl();
});

