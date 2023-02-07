

// SHA1: E1:ED:17:9B:8B:B0:34:47:CE:2A:19:A4:7E:2B:51:5D:43:2E:8C:08


import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {

  // static FirebaseMessaging messaging = FirebaseMessaging.instance;
  // static String? token;
  static StreamController<Map<String, dynamic>> _streamController = new StreamController.broadcast();
  static Stream<Map<String, dynamic>> get messageStream => _streamController.stream;


  static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  // static Future _backgroundHandler( RemoteMessage message ) async {
  //   print('background Handler ${message.messageId}');
  //   Map<String, dynamic> data = messageParse(message);
  //   data['forceRedirect'] = true;
  //   print(data);

  //   _streamController.add(data);
  // }
  // static Future _onMessageHandler( RemoteMessage message ) async {
  //   print('onMessage Handler ${message.messageId}');
  //   Map<String, dynamic> data = messageParse(message);
  //   data['forceRedirect'] = false;
  //   print(data);

  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;

  //   // If `onMessage` is triggered with a notification, construct our own
  //   // local notification to show to users using the created channel.
  //   if (notification != null && android != null) {
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             channelDescription: channel.description,
  //             icon: android.smallIcon,
  //             // other properties...
  //           ),
  //         ));
  //   }

  //   _streamController.add(data);
  // }
  // static Future _onMessageOpenApp( RemoteMessage message ) async {
  //   print('_onMessageOpenApp Handler ${message.messageId}');
  //   Map<String, dynamic> data = messageParse(message);
  //   data['forceRedirect'] = true;
  //   print(data);

  //   _streamController.add(data);
  // }

  // static Map<String, dynamic> messageParse(RemoteMessage message) {
  //   Map<String, dynamic> response = {};
  //   response.addAll(message.data);
  //   response.addAll(message.notification!.toMap());
  //   return response;
  // }

  static Future initializeApp() async {

    // Push notification
    // await Firebase.initializeApp();
    // token = await FirebaseMessaging.instance.getToken();
    // print('token: $token');
    // if (token != null) sendToken(token!);


    // Handlers
    // FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    // FirebaseMessaging.onMessage.listen(_onMessageHandler);
    // FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);


    // Local notification
    await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  }

  static  showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload
      );
  
  static  showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate
  }) async =>
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
      );
  
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

  static Future init({ bool initScheduled = false }) async {
    final android = AndroidInitializationSettings('@mipmap/launcher_icon');
    final iOS = DarwinInitializationSettings();
    final settings = InitializationSettings(
      android: android,
      iOS: iOS
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        _streamController.add({'page': details.payload});
      },
    );
  }

  // static Future sendToken(String token) async {
  //   final String url = 'https://cdleonesa-ff6a7-default-rtdb.europe-west1.firebasedatabase.app/notification_tokens.json';
  //   final body = json.encode({
  //     'token' : token,
  //     'timestamp' : DateTime.now().toString()
  //   });
  //   final resp = await http.post(Uri.parse(url), body: body);
  //   final decodeData = resp.body;
  // }


  static closeStreams() {
    _streamController.close();
  }
  
  


}