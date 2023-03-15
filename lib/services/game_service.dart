import 'dart:convert';
import 'dart:developer';

import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/game_model.dart';
import 'package:cd_leonesa_app/services/push_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GameService with ChangeNotifier {

  List<Game> allGames = [];
  bool isloading = true;
  static String section = 'Futbol';

  GameService() {


    this.getAllGames();
  }


  getAllGames() async {

    this.isloading = true;
    notifyListeners();

    final String url = '${MainTheme.apiBaseUrl}/partido';
    final resp = await http.get(Uri.parse(url));

    final gamesResponse = gameListFromJson(resp.body);

    if (gamesResponse != null)
      for (var game in gamesResponse) {
        await game.getMedia();
      }

    this.allGames = gamesResponse == null? [] : gamesResponse;
    this.allGames.sort((a, b) => a.fecha!.compareTo(b.fecha!));
    this.isloading = false;
    notifyListeners();
    

    scheduleGames();
  }

  Future<void> scheduleGames() async {

    var nextGames = getNextGames();

    for (var game in nextGames) {
      if (game.seccion=='Futbol') {
        Map<String, dynamic> payload = {
                                'page': 'team',
                                'id': '0'
                              };
        await PushNotificationService.showScheduledNotification(
          id: game.id ?? 0,
          title: 'Finalizo el partido',
          body: 'Califica el juego Cultural VS ${game.equipoContrario}',
          payload: payload,
          scheduledDate: game.fecha!.add(Duration(hours: 2))
        );
      }
    }


  }

  static Future<bool> sendSurvey(Map<String, dynamic> payload) async {
    Uri uri =
        Uri.parse('${MainTheme.apiBaseUrl}/encuesta');
    var bodyEncode = jsonEncode(payload);
    Map<String, String> headers = {'Authorization': 'Basic YXBwOjVYWUEgVnVNVyBrbFcyIEJJWFAgY1Z6MyBQbjFl'};
    var response = await http.post(uri, body: bodyEncode, headers: headers);

    // print(response.statusCode);
    // print(payload);
    return response.statusCode == 201;  

  }

  Game? getLastGame() {
    DateTime today = DateTime.now();
    var lastGame = allGamesFilterBySection().where((i) => (i.fecha ?? today).isBefore(today)).toList();
    if (lastGame.isEmpty) return null;
    return lastGame.last;
  }

  Game? getNextGame() {
    DateTime today = DateTime.now();
    var nextGame = allGamesFilterBySection().where((i) => (i.fecha ?? today).isAfter(today)).toList();
    if (nextGame.isEmpty) return null;
    return nextGame.first;

  }

  Game getGameForSurvey() {
    DateTime today = DateTime.now().add(Duration(hours: -2));
    var lastGame = allGamesFilterBySection().where((i) => (i.fecha ?? today).isBefore(today)).toList();
    return lastGame.last;

  }

  List<Game> getLastGames() {
    DateTime today = DateTime.now();
    return allGamesFilterBySection().where((i) => (i.fecha ?? today).isBefore(today)).toList();
  }

  List<Game> getNextGames() {
    DateTime today = DateTime.now();
    return allGamesFilterBySection().where((i) => (i.fecha ?? today).isAfter(today)).toList();
  }

  List<Game> getGamesByMonth(String month) {
    DateTime today = DateTime.now();
    DateTime minLimit = DateTime.parse('$month-01');
    DateTime maxLimit = DateTime.parse('$month-31');
    // return allGames;
    return allGamesFilterBySection().where((i) =>
      ( (i.fecha ?? today).isAfter(minLimit))
      && (i.fecha ?? today).isBefore(maxLimit))
      .toList();
  }

  List<Game> allGamesFilterBySection() {
    return allGames.where((i) => (i.seccion == section)).toList();
  }


}