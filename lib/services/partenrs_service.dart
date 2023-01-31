import 'dart:developer';

import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/partners_model.dart';
import 'package:cd_leonesa_app/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PartnerService with ChangeNotifier {

  List<Partner> allPartners = [];
  bool isloading = true;

  PartnerService() {


    this.getAllPartners();
  }


  getAllPartners() async {

    this.isloading = true;
    notifyListeners();

    final String url = '${MainTheme.apiBaseUrl}/patrocinador';
    final resp = await http.get(Uri.parse(url));

    final partnerrsResponse = partnerListFromJson(resp.body);

    if (partnerrsResponse != null) {
      for (var partnerr in partnerrsResponse) {
        await partnerr.getMedia();
      }

      partnerrsResponse.sort((a, b) => a.categoryId!.compareTo(b.categoryId!));
      this.allPartners = partnerrsResponse == null ? [] : partnerrsResponse;
    }
    this.isloading = false;
    notifyListeners();
    
  }


}