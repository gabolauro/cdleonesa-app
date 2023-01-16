import 'package:cd_leonesa_app/pages/calendar_grid_page.dart';
import 'package:cd_leonesa_app/pages/calendar_list_page.dart';
import 'package:cd_leonesa_app/pages/calendar_page.dart';
import 'package:cd_leonesa_app/pages/century_page.dart';
import 'package:cd_leonesa_app/pages/home_page.dart';
import 'package:cd_leonesa_app/pages/loading_page.dart';
import 'package:cd_leonesa_app/pages/news_page.dart';
import 'package:cd_leonesa_app/pages/partners_page.dart';
import 'package:cd_leonesa_app/pages/settings_page.dart';
import 'package:cd_leonesa_app/pages/single_news_page.dart';
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
  'partners' : (_) {
    return PartnersPage();
  },
  'century' : (_) {
    return CenturyPage();
  },
  'calendar' : (_) {
    return CalendarPage();
  },
  'calendar-grid' : (_) {
    return CalendarGridPage();
  },
  'calendar-list' : (_) {
    return CalendarListPage();
  },
  'settings' : (_) {
    return SettingsPage();
  }
};