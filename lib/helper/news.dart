import 'dart:convert';

import 'package:news_api/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getnews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=1c1029e7244a4acdaba0272275dea311";
    var response = await http.get(url);
    var jsondata = jsonDecode(response.body);

    if (jsondata['status'] == 'ok') {
      jsondata['articles'].forEach((element) {
        if(element["urlToImage"] !=null && element['description'] !=null){

          ArticleModel articleModel= ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],


          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getnews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=1c1029e7244a4acdaba0272275dea311";
    var response = await http.get(url);
    var jsondata = jsonDecode(response.body);

    if (jsondata['status'] == 'ok') {
      jsondata['articles'].forEach((element) {
        if(element["urlToImage"] !=null && element['description'] !=null){

          ArticleModel articleModel= ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],


          );
          news.add(articleModel);
        }
      });
    }
  }
}