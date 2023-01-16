import 'package:carousel_slider/carousel_slider.dart';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/ui_components/last_game.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      background: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Calendario',
              style: TextStyle(
                fontSize: 28,
                color: MainTheme.mainColor,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.none
              ),
            ),
          ),

          CarouselSlider(
            items: [

              EventCard(),
              EventCard(),
              EventCard(),

            ],
            options: CarouselOptions(
              // height: 350,
                aspectRatio: 2.0,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: false,
                enableInfiniteScroll: false
              )
          ),

          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, 'calendar-list');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Ver',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none
                        ),
                      children: [
                          TextSpan(
                            text: ' calendario completo',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/arrow_right.svg',
                    color: Colors.black26,
                    height: 14,
                    allowDrawingOutsideViewBox: true,
                  ),
                )
              ],
            ),
          ),

          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder:(context, index) {
              print(index%2);
              return LastGame(
                background: index%2 == 0
                  ? Colors.black.withOpacity(0.05)
                  : Colors.white,
              );
            },
          )
        ],
      )
   );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black12, width: 4)
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 4
                      ),
                    )
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'VIERNES',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w200,
                                decoration: TextDecoration.none
                              ),
                            children: [
                                TextSpan(
                                  text: ' 06 ENE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                          width: 4
                        ),
                      )
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: double.infinity),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Image.asset('assets/images/logo_01.png'),
                                  ),
                                ),
                                Text(
                                  'VS',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black12,
                                    letterSpacing: -5
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Image.network(
                                      'https://cydleonesa.com/wp-content/uploads/2023/01/adceuta-logo.png'
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Cultural',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            'Unionista',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child: Text(
                      'Estadio Reino de Leon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: MainTheme.mainColor,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none,
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}