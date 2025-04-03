import 'package:blog_mobile/main.dart';
import 'package:blog_mobile/pages/login/loginState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Loginctrl extends StateNotifier<LoginState>{
  Loginctrl():super(LoginState()){
    //init
  }

  Future soumettreFormulaire() async{
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 3));
    state = state.copyWith(isLoading: false);
  }
}

final loginCtrlProvider = StateNotifierProvider<Loginctrl, LoginState>((ref){
  ref.keepAlive();
  return Loginctrl();
});