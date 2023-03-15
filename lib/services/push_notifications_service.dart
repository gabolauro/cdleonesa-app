

// SHA1: E1:ED:17:9B:8B:B0:34:47:CE:2A:19:A4:7E:2B:51:5D:43:2E:8C:08
// P8 - Key ID: 2GR729AWQS


import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? _token;
  static StreamController<Map<String, dynamic>> _streamController = new StreamController.broadcast();
  static Stream<Map<String, dynamic>> get messageStream => _streamController.stream;
  static Map<String, dynamic> initialPayload = {'forceRedirect':false};

  static void notificationTapBackground(NotificationResponse details) {
    Map<String, dynamic> payload = jsonDecode(details.payload!);
    payload['forceRedirect'] = true;
    initialPayload = payload;
    _streamController.add(payload);
  }

  static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
      iOS: DarwinNotificationDetails() ,
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        icon: '@mipmap/launcher_icon',
        // other properties...
      ),
    );
  }

  static Future _backgroundHandler( RemoteMessage message ) async {
    print('background Handler ${message.messageId}');
    Map<String, dynamic> data = messageParse(message);
    data['forceRedirect'] = true;
    print(data);
    initialPayload = data;

    _streamController.add(data);
  }
  static Future _onMessageHandler( RemoteMessage message ) async {
    print('onMessage Handler ${message.messageId}');
    Map<String, dynamic> data = messageParse(message);
    data['forceRedirect'] = false;
    print(data);

    RemoteNotification? notification = message.notification;
    if (notification != null) {
      await showNotification(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        payload: data
      );
    }


    // _streamController.add(data);
  }
  static Future _onMessageOpenApp( RemoteMessage message ) async {
    print('_onMessageOpenApp Handler ${message.messageId}');
    Map<String, dynamic> data = messageParse(message);
    data['forceRedirect'] = true;
    print(data);
    initialPayload = data;

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
    _token = await FirebaseMessaging.instance.getToken();
    print('token: $_token');
    // if (_token != null) sendToken(_token!);


    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);


    // Local notification
    await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

    final android = AndroidInitializationSettings('@mipmap/launcher_icon');
    final iOS = DarwinInitializationSettings();
    final settings = InitializationSettings(
      android: android,
      iOS: iOS
    );

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      notificationTapBackground(notificationAppLaunchDetails!.notificationResponse!);
    }

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        Map<String, dynamic> payload = jsonDecode(details.payload!);
        payload['forceRedirect'] = true;
        _streamController.add(payload);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground
    );
  }

  static  showNotification({
    int id = 0,
    String? title,
    String? body,
    Map<String, dynamic>? payload,
  }) async =>
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: jsonEncode(payload)
      );
  
  static  showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    Map<String, dynamic>? payload,
    required DateTime scheduledDate
  }) async =>
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      await _notificationDetails(),
      payload: jsonEncode(payload),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
      );

  static Future sendToken(String token) async {
    final String url = 'https://cdleonesa-ff6a7-default-rtdb.europe-west1.firebasedatabase.app/notification_tokens.json';
    final body = json.encode({
      'token' : token,
      'timestamp' : DateTime.now().toString()
    });
    final resp = await http.post(Uri.parse(url), body: body);
    final decodeData = resp.body;
  }


  static String get token {
    return _token ?? '';
  }


  static closeStreams() {
    _streamController.close();
  }
  
  


}