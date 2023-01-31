

// SHA1: E1:ED:17:9B:8B:B0:34:47:CE:2A:19:A4:7E:2B:51:5D:43:2E:8C:08


import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<Map<String, dynamic>> _streamController = new StreamController.broadcast();
  static Stream<Map<String, dynamic>> get messageStream => _streamController.stream;

  static Future _backgroundHandler( RemoteMessage message ) async {
    print('background Handler ${message.messageId}');
    Map<String, dynamic> data = messageParse(message);
    data['forceRedirect'] = true;
    print(data);

    _streamController.add(data);
  }
  static Future _onMessageHandler( RemoteMessage message ) async {
    print('onMessage Handler ${message.messageId}');
    Map<String, dynamic> data = messageParse(message);
    data['forceRedirect'] = false;
    print(data);

    _streamController.add(data);
  }
  static Future _onMessageOpenApp( RemoteMessage message ) async {
    print('_onMessageOpenApp Handler ${message.messageId}');
    Map<String, dynamic> data = messageParse(message);
    data['forceRedirect'] = true;
    print(data);

    _streamController.add(data);
  }

  static Map<String, dynamic> messageParse(RemoteMessage message) {
    Map<String, dynamic> response = {};
    response.addAll(message.data);
    response.addAll(message.notification!.toMap());
    return response;
  }

  static Future initializeApp() async {

    // Push notification
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('token: $token');
    if (token != null) sendToken(token!);


    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);


    // Local notification

  }

  static Future sendToken(String token) async {
    final String url = 'https://cdleonesa-ff6a7-default-rtdb.europe-west1.firebasedatabase.app/notification_tokens.json';
    final body = json.encode({
      'token' : token,
      'timestamp' : DateTime.now().toString()
    });
    final resp = await http.post(Uri.parse(url), body: body);
    final decodeData = resp.body;
  }


  static closeStreams() {
    _streamController.close();
  }


}