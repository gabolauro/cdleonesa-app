import 'dart:convert';

import 'package:cd_leonesa_app/services/player_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _prefs;

  static String _place = '';
  static int _player = 0;
  static int _attack = 0;
  static int _fence = 0;
  static int _gameId = 0;
  static bool _isSent = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get place {
    return _prefs.getString('place') ?? _place;
  }
  static set place( String place ) {
    _place = place;
    _prefs.setString('place', place );
  }

  static int get player {
    return _prefs.getInt('player') ?? _player;
  }
  static set player( int playerId ) {
    _player = playerId;
    _prefs.setInt('player', playerId );
  }

  static int get attack {
    return _prefs.getInt('attack') ?? _attack;
  }
  static set attack( int attackId ) {
    _attack = attackId;
    _prefs.setInt('attack', attackId );
  }

  static int get fence {
    return _prefs.getInt('fence') ?? _fence;
  }
  static set fence( int fenceId ) {
    _fence = fenceId;
    _prefs.setInt('fence', fenceId );
  }

  static int get gameId {
    return _prefs.getInt('gameId') ?? _gameId;
  }
  static set gameId( int gameId ) {
    _gameId = gameId;
    _prefs.setInt('gameId', gameId );
  }

  static bool get isSent {
    return _prefs.getBool('isSent') ?? _isSent;
  }
  static set isSent( bool isSentId ) {
    _isSent = isSentId;
    _prefs.setBool('isSent', isSentId );
  }

  static resetAllValues() {
    _prefs.setString('place', '' );
    _prefs.setInt('player', 0 );
    _prefs.setInt('attack', 0 );
    _prefs.setInt('fence', 0 );
    _prefs.setInt('gameId', 0 );
    _prefs.setBool('isSent', false );
  }

  // static bool get isDarkmode {
  //   return _prefs.getBool('isDarkmode') ?? _isDarkmode;
  // }

  // static set isDarkmode( bool value ) {
  //   _isDarkmode = value;
  //   _prefs.setBool('isDarkmode', value );
  // }

  // static int get gender {
  //   return _prefs.getInt('gender') ?? _gender;
  // }

  // static set gender( int value ) {
  //   _gender = value;
  //   _prefs.setInt('gender', value );
  // }


}