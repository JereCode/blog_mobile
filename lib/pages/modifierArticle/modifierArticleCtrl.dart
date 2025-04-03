import 'package:blog_mobile/Business/models/Category.dart';
import 'package:blog_mobile/pages/ModifierArticle/ModifierArticleState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Business/services/blogNetworkService.dart';
import '../../main.dart';

class ModifierArticleCtrl extends StateNotifier<ModifierArticleState>{
  var blogNetworkService = getIt.get<BloNetworkService>();
  ModifierArticleCtrl():super(ModifierArticleState()){
    recupererCategories();
  }

  Future<void> recupererArticleParId(int articleId) async{
    //state = state.copyWith(article: )
  }
  Future<void> recupererCategories() async{

    state=state.copyWith(isLoading: true);
    var res= await blogNetworkService.recupererCategories();
    state=state.copyWith(isLoading: false, categories: res);
  }
  Future<void> modifierArticle(int articleId) async{}

}

final modifierArticleCtrlProvider = StateNotifierProvider<ModifierArticleCtrl, ModifierArticleState>((ref){
  return ModifierArticleCtrl();
});