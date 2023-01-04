import 'package:cd_leonesa_app/pages/calendar_page.dart';
import 'package:cd_leonesa_app/pages/century_page.dart';
import 'package:cd_leonesa_app/pages/home_page.dart';
import 'package:cd_leonesa_app/pages/loading_page.dart';
import 'package:cd_leonesa_app/pages/museum_page.dart';
import 'package:cd_leonesa_app/pages/news_page.dart';
import 'package:cd_leonesa_app/pages/partners_page.dart';
import 'package:cd_leonesa_app/pages/settings_page.dart';
import 'package:cd_leonesa_app/pages/single_news_page.dart';
import 'package:cd_leonesa_app/pages/store_page.dart';
import 'package:cd_leonesa_app/pages/team_page.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:flutter/material.dart';


final Map<String, Widget Function (BuildContext)> appRoutes = {
  'loading' : (_) => LoadingPage(),
  'home' : (_) => HomePage(),
  'news' : (_) {
    MainFrame.currentIndex = 0;
    return NewsPage();
  },
  'single_news' : (_) => SingleNewsPage(),
  'team' : (_) {
    MainFrame.currentIndex = 1;
    return TeamPage();
  },
  'store' : (_) {
    MainFrame.currentIndex = 2;
    return StorePage();
  },
  'museum' : (_) {
    MainFrame.currentIndex = 3;
    return MuseumPage();
  },
  'partners' : (_) {
    return PartnersPage();
  },
  'century' : (_) {
    return CenturyPage();
  },
  'calendar' : (_) {
    return CalendarPage();
  },
  'settings' : (_) {
    return SettingsPage();
  }
};