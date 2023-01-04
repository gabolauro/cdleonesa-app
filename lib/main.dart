import 'package:cd_leonesa_app/routes/routes.dart';
import 'package:flutter/material.dart';

import 'constants/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'C&D Leonesa App',
      initialRoute: 'loading',
      routes: appRoutes,
      theme: MainTheme.theme(),
    );
  }
}

