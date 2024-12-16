import 'package:flutter/material.dart';
import 'package:flutter_application_1/article.dart';


class Cart extends ChangeNotifier{
  final _listArticles = <Article>[];
  
  List<Article> getAll()=> _listArticles;
  void add(Article article){
    _listArticles.add(article);
    notifyListeners();
  }
  void remove(Article article){
    _listArticles.remove(article);
    notifyListeners();
  }
  
}
