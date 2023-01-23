import 'dart:developer';

import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/player_model.dart';
import 'package:cd_leonesa_app/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlayerService with ChangeNotifier {

  List<Player> allPlayers = [];
  int favPlayer = Preferences.player;
  int attackGame = Preferences.attack;
  int fenceGame = Preferences.fence;
  bool isloading = true;

  PlayerService() {


    this.getAllPlayers();
  }


  getAllPlayers() async {

    this.isloading = true;
    notifyListeners();

    final String url = '${MainTheme.apiBaseUrl}/jugador?equipo=77&demarcacion=101,102,103,104';
    final resp = await http.get(Uri.parse(url));

    final playersResponse = playerListFromJson(resp.body);

    if (playersResponse != null) {
      for (var player in playersResponse) {
        await player.getMedia();
      }

      playersResponse.sort((a, b) => a.demarcacionId!.compareTo(b.demarcacionId!));
      this.allPlayers = playersResponse == null ? [] : playersResponse;
    }
    this.isloading = false;
    notifyListeners();
    
  }

  setFavPlayer(int playerId) {
    favPlayer = playerId;
    Preferences.player = playerId;
    notifyListeners();
  }


}