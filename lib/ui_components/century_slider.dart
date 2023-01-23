import 'dart:ui';

import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/services/news_service.dart';
import 'package:cd_leonesa_app/ui_components/news_banner.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';


class EventSlider extends StatefulWidget {
  const EventSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<EventSlider> createState() => _EventSliderState();
}

class _EventSliderState extends State<EventSlider> {

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {

    final newsServide = Provider.of<NewsService>(context);

    List<Widget> _buildBanners() {
      if (newsServide.centuryNewsList.isNotEmpty) {
        List<Widget> list = [];
        newsServide.centuryNewsList.forEach((article) async {
          list.add(
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFa8631e),
                        Color(0xFFdfb553),
                        Color(0xFFdfb553),
                        Color(0xFFd8bc80),
                        Color(0xFFa8631e),
                      ]
                    )
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 1,
                        right: 1,
                        bottom: 1,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          color: Colors.black87,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Color(0xFFdfb553),
                              // MainTheme.mainColorDark,
                              BlendMode.color
                            ),
                            child: NewsBanner(
                              id: article.id,
                              image: Image.network(
                                article.resourceMedia ?? MainTheme.noPhoto,
                                fit: BoxFit.cover,
                              ),
                              title: article.title ?? '',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        bottom: 1,
                        right: 1,
                        left: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                                0.3,
                                0.8
                              ],
                              colors: [
                                Color(0xFF000000),
                                Colors.transparent,
                              ]
                            )
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/centenario_logo.png', height: 100,)
                        ),
                      )
                    ],
                  )
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'single_news', arguments: article.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFa8631e),
                            Color(0xFFdfb553),
                            Color(0xFFdfb553),
                            Color(0xFFd8bc80),
                            Color(0xFFa8631e),
                          ]
                        )
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.25),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 1,
                            bottom: 1,
                            left: 1,
                            right: 1,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient:  LinearGradient(
                                  colors: [
                                    Color(0xFF910E1E),
                                    Color(0xFFD00713),
                                  ],
                                )
                              ),
                              child: Text(
                                '+ INFO',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                )
              ],
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

    return Container(
      color: MainTheme.mainColor,
      height: MediaQuery.of(context).size.width ,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: [

                ..._buildBanners(),

              ],
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.width ,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
                )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildBanners().asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}