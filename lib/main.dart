import 'package:cd_leonesa_app/routes/routes.dart';
import 'package:cd_leonesa_app/services/game_service.dart';
import 'package:cd_leonesa_app/services/news_service.dart';
import 'package:cd_leonesa_app/services/partenrs_service.dart';
import 'package:cd_leonesa_app/services/player_service.dart';
import 'package:cd_leonesa_app/services/preferences.dart';
import 'package:cd_leonesa_app/services/push_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'constants/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await PushNotificationService.initializeApp();

  await Preferences.init();

  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    
    // Context
    // PushNotificationService.messageStream.listen((data) {
    //   print('MyApp: $data');
    //   // navigatorKey.currentState?.pushNamed('team');
    //   Function()? snackBarAction = null;
    //   if (data['forceRedirect'] && data.containsKey('page')) {
    //     navigatorKey.currentState?.pushNamed(data['page'], arguments: int.parse(data['id']));
    //   } else {
    //     snackBarAction = () => navigatorKey.currentState?.pushNamed(data['page'], arguments: int.parse(data['id']));
    //   }

    //   final snackBar = MainTheme.message(context, data: data, action: snackBarAction);
    //   if (!data['forceRedirect']) messengerKey.currentState?.showSnackBar(snackBar);
    // });

    PushNotificationService.init();
    listenNotifications();

  }

  void listenNotifications() {
    PushNotificationService.messageStream.listen((data) {
      // print('MyApp: $data');
      if (data.containsKey('page')) {
        Preferences.resetAllValues();
        navigatorKey.currentState?.pushNamed(data['page']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_) => NewsService()),
        ChangeNotifierProvider(create:(_) => GameService()),
        ChangeNotifierProvider(create:(_) => PlayerService()),
        ChangeNotifierProvider(create:(_) => PartnerService()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: messengerKey,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          SfGlobalLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('es'),
        ],
        locale: const Locale('es'),
        debugShowCheckedModeBanner: false,
        title: 'C&D Leonesa App',
        initialRoute: 'home',
        routes: appRoutes,
        theme: MainTheme.theme(),
      ),
    );
  }
}

