import 'package:carousel_slider/carousel_slider.dart';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/services/news_service.dart';
import 'package:cd_leonesa_app/ui_components/news_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsSlider extends StatelessWidget {
  const NewsSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newsServide = Provider.of<NewsService>(context);

    List<Widget> _buildBanners() {
      if (newsServide.headlines.isNotEmpty) {
        List<Widget> list = [];
        newsServide.headlines.forEach((article) async {
          list.add(
            NewsBanner(
              id: article.id,
              image: Image.network(
                article.resourceMedia ?? MainTheme.noPhoto,
                fit: BoxFit.cover,
              ),
              title: article.title ?? '',
            ),
          );
        });
        return list;
      }

      return [
        Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
      ];
    }

    return CarouselSlider(
      items: [
        ..._buildBanners()
      ],
      options: CarouselOptions(
          height: 300,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
      )
    );
  }
}