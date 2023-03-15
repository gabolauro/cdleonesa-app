import 'dart:developer';

import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class StoreService with ChangeNotifier {

  List<Store> saleList = [];
  bool isloading = true;
  

  StoreService() {


    this.loadAll();
  }

  loadAll() async {
    this.isloading = true;
    notifyListeners();
    this.getAllSales();
    this.isloading = false;
    notifyListeners();

    // notifyListeners();

  }


  Future<void> getAllSales() async {
    
    final String url = '${MainTheme.apiBaseUrl}/posts?categories=192';
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsListFromJson(resp.body);

    if (newsResponse != null) {
      for (var article in newsResponse) {
        await article.getMedia();
        this.saleList.add(article);
        notifyListeners();
      }
    }

  }
  

  Store getFirstSale() {

    return saleList.first;
  }

}