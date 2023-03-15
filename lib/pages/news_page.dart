import 'dart:developer';
import 'dart:ui';

import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/news_model.dart';
import 'package:cd_leonesa_app/services/news_service.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:cd_leonesa_app/ui_components/news_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NewsPage extends StatefulWidget {

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    final newsServide = Provider.of<NewsService>(context);
    final section = ModalRoute.of(context)!.settings.arguments as String;
    List newsList() {
      if (section=='Fútbol') {
        return newsServide.futbolNewsList;
      } else if (section=='Fútbol Femenino') {
        return newsServide.femaleFutbolNewsList;
      } else if (section=='Baloncesto') {
        return newsServide.basketNewsList;
      }
      return [];
    };

    return MainFrame(
      background: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Noticias',
                style: TextStyle(
                    fontSize: 28,
                    color: MainTheme.mainColor,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none
                  ),
                children: [
                    TextSpan(
                      text: section,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // SizedBox(height: 10,),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: newsList().length,
              itemBuilder:(_, i) {

                News article = newsList()[i];

                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 250),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: NewsBanner(
                      id: article.id,
                      image: Image.network(
                        article.resourceMedia ?? MainTheme.noPhoto,
                        fit: BoxFit.cover,
                      ),
                      title: article.title ?? '',
                    ),
                  ),
                );
              },
            ),
          ),


        ],
      ),
   );
  }
}