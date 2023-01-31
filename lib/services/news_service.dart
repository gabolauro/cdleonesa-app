import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NewsService with ChangeNotifier {

  List<News> headlines = [];
  List<News> centuryNewsList = [];
  List<News> futbolNewsList = [];
  List<News> femaleFutbolNewsList = [];
  List<News> basketNewsList = [];
  bool isloading = true;
  

  NewsService() {


    this.loadAll();
  }

  loadAll() async {
    this.isloading = true;
    notifyListeners();
    this.getTopHeadlines();
    this.getTopCentury();
    this.isloading = false;
    notifyListeners();
    await this.getTopFutbol();
    await this.getTopFemaleFutbol();
    await this.getTopBasket();
    // notifyListeners();

  }


  Future<void> getTopHeadlines() async {
    
    final String url = '${MainTheme.apiBaseUrl}/posts?categories=1';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsListFromJson(resp.body);

    if (newsResponse != null) {
      for (var article in newsResponse) {
        await article.getMedia();
        this.headlines.add(article);
        notifyListeners();
      }
    }

    // this.headlines = newsResponse == null ? [] : newsResponse;
    // notifyListeners();
  }
  Future<void> getTopCentury() async {
    
    final String url = '${MainTheme.apiBaseUrl}/posts?categories=2';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsListFromJson(resp.body);

    if (newsResponse != null) {
      for (var article in newsResponse) {
        await article.getMedia();
        this.centuryNewsList.add(article);
        notifyListeners();
      }
    }

    // this.centuryNewsList = newsResponse == null ? [] : newsResponse;
    // notifyListeners();
  }
  Future<void> getTopFutbol() async {
    
    final String url = '${MainTheme.apiBaseUrl}/posts?categories=2';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsListFromJson(resp.body);

    if (newsResponse != null)
    for (var article in newsResponse) {
      await article.getMedia();
    }

    this.futbolNewsList = newsResponse == null ? [] : newsResponse;
    notifyListeners();
  }
  Future<void> getTopFemaleFutbol() async {
    
    final String url = '${MainTheme.apiBaseUrl}/posts?categories=2';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsListFromJson(resp.body);

    if (newsResponse != null)
    for (var article in newsResponse) {
      await article.getMedia();
    }

    this.femaleFutbolNewsList = newsResponse == null ? [] : newsResponse;
    notifyListeners();
  }
  Future<void> getTopBasket() async {
    
    final String url = '${MainTheme.apiBaseUrl}/posts?categories=2';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsListFromJson(resp.body);

    if (newsResponse != null)
    for (var article in newsResponse) {
      await article.getMedia();
    }

    this.basketNewsList = newsResponse == null ? [] : newsResponse;
    notifyListeners();
  }

  News getSingleHeadline(int id) {
    var allNews = [
      ...this.futbolNewsList,
      ...this.femaleFutbolNewsList,
      ...this.basketNewsList,
      ...this.centuryNewsList,
      ...this.headlines
    ];
    return allNews.where((i) => i.id == id).first;
  }

}