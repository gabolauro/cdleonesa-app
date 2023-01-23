import 'package:cd_leonesa_app/routes/routes.dart';
import 'package:cd_leonesa_app/services/game_service.dart';
import 'package:cd_leonesa_app/services/news_service.dart';
import 'package:cd_leonesa_app/services/player_service.dart';
import 'package:cd_leonesa_app/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'constants/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_) => NewsService()),
        ChangeNotifierProvider(create:(_) => GameService()),
        ChangeNotifierProvider(create:(_) => PlayerService()),
      ],
      child: MaterialApp(
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
        initialRoute: 'loading',
        routes: appRoutes,
        theme: MainTheme.theme(),
      ),
    );
  }
}

