import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NewsService with ChangeNotifier {

  List<News> headlines = [];
  

  NewsService() {


    this.getTopHeadlines();
  }


  getTopHeadlines() async {
    
    final String url = '${MainTheme.apiBaseUrl}/posts';
    final resp = await http.get(Uri.parse(url));
    // print(resp.body);

    final newsResponse = newsListFromJson(resp.body);

    if (newsResponse != null)
    for (var article in newsResponse) {
      await article.getMedia();
    }

    this.headlines = newsResponse == null ? [] : newsResponse;
    notifyListeners();

  }

  News getSingleHeadline(int id) {
    return this.headlines.where((i) => i.id == id).first;
  }

}