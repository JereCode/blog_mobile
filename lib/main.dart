import 'package:blog_mobile/Business/services/blogLocalService.dart';
import 'package:blog_mobile/framework/blogLocalServiceImpl.dart';
import 'package:blog_mobile/framework/blogNetworkServiceImpl.dart';
import 'package:blog_mobile/pages/login/loginPage.dart';
import 'package:blog_mobile/pages/modifierArticle/modifierArticlePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'Business/services/blogNetworkService.dart';

var getIt = GetIt.instance;
void setup(){
  getIt.registerLazySingleton<BloNetworkService>((){
    var baseUrl=dotenv.env["BASE_URL"];
    return BloNetworkServiceImpl(baseUrl: baseUrl??"");
  });

  getIt.registerLazySingleton<BloglocalService>((){
    return BlogLocalServiceImpl();
  });
}

void main() async{
  await dotenv.load(fileName: ".env");
  setup();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ModifierArticlePage(articleId: 1,),
    );
  }
}