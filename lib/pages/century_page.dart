import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/news_model.dart';
import 'package:cd_leonesa_app/services/news_service.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:cd_leonesa_app/ui_components/news_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CenturyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsServide = Provider.of<NewsService>(context);

    return MainFrame(
      background: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              height: 150,
              width: double.infinity,
              alignment: Alignment.center,
              child: Image.asset('assets/images/centenario_logo.png')
            ),
            
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: newsServide.centuryNewsList.length,
              itemBuilder:(context, index) {

                News article = newsServide.centuryNewsList[index];

                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 300),
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
            )
          ],
        ),
      )
   );
  }
}