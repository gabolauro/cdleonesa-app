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
  late PageController controller;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);

    _currentPage = 0;
    controller.addListener(() {
      setState(() {
        _currentPage = controller.page!.ceil().toInt();
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    final newsServide = Provider.of<NewsService>(context);

    return MainFrame(
      background: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 0),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black87,
                  width: 0.5,
                ),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: _currentPage == 0 ? MainTheme.mainColor : Colors.transparent,
                        width: _currentPage == 0 ? 3 : 0,
                      ),
                    )
                  ),
                  child: TextButton(
                    onPressed:() {
                      controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                    },
                    child: Text(
                      'Futbol',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: _currentPage == 0
                          ? FontWeight.w800
                          : FontWeight.w400
                      ),
                    )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: _currentPage == 1 ? MainTheme.mainColor : Colors.transparent,
                        width: _currentPage == 1 ? 3 : 0,
                      ),
                    )
                  ),
                  child: TextButton(
                    onPressed:() {
                      controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                    },
                    child: Text(
                      'Futbol Femenino',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: _currentPage == 1
                          ? FontWeight.w800
                          : FontWeight.w400
                      ),
                    )),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: _currentPage == 2 ? MainTheme.mainColor : Colors.transparent,
                        width: _currentPage == 2 ? 3 : 0,
                      ),
                    )
                  ),
                  child: TextButton(
                    onPressed:() {
                      controller.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                    },
                    child: Text(
                      'Baloncesto',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: _currentPage == 2
                          ? FontWeight.w800
                          : FontWeight.w400
                      ),
                    )),
                ),
              ],
            ),
          ),

          SizedBox(height: 10,),

          Expanded(
            child: PageView(
              controller: controller,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsServide.futbolNewsList.length,
                  itemBuilder:(_, i) {

                    News article = newsServide.futbolNewsList[i];

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
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsServide.femaleFutbolNewsList.length,
                  itemBuilder:(_, i) {

                    News article = newsServide.femaleFutbolNewsList[i];

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
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsServide.basketNewsList.length,
                  itemBuilder:(_, i) {

                    News article = newsServide.basketNewsList[i];

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
                ),

              ],
            ),
          ),


        ],
      ),
   );
  }
}