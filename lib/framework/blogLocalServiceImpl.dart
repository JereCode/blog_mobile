import 'package:blog_mobile/Business/models/User.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import '../Business/services/blogLocalService.dart';

class BlogLocalServiceImpl implements BloglocalService{
  GetStorage? box;

  BlogLocalServiceImpl({this.box});
  @override
  Future<bool> sauvegarderUser(User user) async{
    var data = user.toMap();
    await box?.write("user", jsonEncode(data));
    return true;
  }

}