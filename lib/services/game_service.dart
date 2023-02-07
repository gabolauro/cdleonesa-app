import 'dart:developer';

import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/game_model.dart';
import 'package:cd_leonesa_app/services/push_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GameService with ChangeNotifier {

  List<Game> allGames = [];
  bool isloading = true;

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
      await PushNotificationService.showScheduledNotification(
        id: game.id ?? 0,
        title: 'Finalizo el partido',
        body: 'Califica el juego Cultural VS ${game.equipoContrario}',
        payload: 'team',
        scheduledDate: game.fecha!.add(Duration(hours: 2))
      );
    }


  }

  Game? getLastGame() {
    DateTime today = DateTime.now();
    var lastGame = allGames.where((i) => (i.fecha ?? today).isBefore(today)).toList();
    if (lastGame.isEmpty) return null;
    return lastGame.last;
  }

  Game? getNextGame() {
    DateTime today = DateTime.now();
    var nextGame = allGames.where((i) => (i.fecha ?? today).isAfter(today)).toList();
    if (nextGame.isEmpty) return null;
    return nextGame.first;

  }

  List<Game> getLastGames() {
    DateTime today = DateTime.now();
    return allGames.where((i) => (i.fecha ?? today).isBefore(today)).toList();
  }

  List<Game> getNextGames() {
    DateTime today = DateTime.now();
    return allGames.where((i) => (i.fecha ?? today).isAfter(today)).toList();
  }

  List<Game> getGamesByMonth(String month) {
    DateTime today = DateTime.now();
    DateTime minLimit = DateTime.parse('$month-01');
    DateTime maxLimit = DateTime.parse('$month-31');
    // return allGames;
    return allGames.where((i) =>
      ( (i.fecha ?? today).isAfter(minLimit))
      && (i.fecha ?? today).isBefore(maxLimit))
      .toList();
  }


}