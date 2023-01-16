import 'package:carousel_slider/carousel_slider.dart';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class TeamPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      background: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: RichText(
              text: const TextSpan(
                text: 'Valora',
                style: TextStyle(
                    fontSize: 28,
                    color: MainTheme.mainColor,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none
                  ),
                children: [
                    TextSpan(
                      text: ' el ',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextSpan(
                      text: 'partido',
                      style: TextStyle(
                        // fontWeight: FontWeight.w800,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '¿Dónde has visto el partido?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _menuItem(
                svgAsset: 'assets/images/time.svg',
                title: 'No lo he visto',
                callback: () {
                }
              ),
              _menuItem(
                svgAsset: 'assets/images/stadium.svg',
                title: 'En el campo',
                callback: () {
                }
              ),
              _menuItem(
                svgAsset: 'assets/images/tv.svg',
                title: 'Por la TV',
                callback: () {
                }
              ),
            ],
          ),
          Text(
            '¿Quién ha sido el MVP?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black87
            ),
          ),
          PlayerSlider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Valoración general',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 60, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            'assets/images/arrow_right.svg',
                            color: Colors.black38,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Ataque',
                              style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w400),)
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            'assets/images/star.svg',
                            color: MainTheme.mainColor,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                          SvgPicture.asset(
                            'assets/images/star.svg',
                            color: MainTheme.mainColor,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                          SvgPicture.asset(
                            'assets/images/star.svg',
                            color: MainTheme.mainColor,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 1,
                  height: 80,
                  color: Colors.black38,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Defensa',
                              style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w400),)
                          ),
                          SvgPicture.asset(
                            'assets/images/arrow_left.svg',
                            color: Colors.black38,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            'assets/images/star.svg',
                            color: MainTheme.mainColor,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                          SvgPicture.asset(
                            'assets/images/star.svg',
                            color: MainTheme.mainColor,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                          SvgPicture.asset(
                            'assets/images/star.svg',
                            color: Colors.black38,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
   );
  }


  Widget _menuItem({
    required String svgAsset,
    required String title,
    required Function() callback
  }) {
    return GestureDetector(
      onTap: callback,
      child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  svgAsset,
                  color: MainTheme.mainColor,
                  height: 28,
                  allowDrawingOutsideViewBox: true,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(title, style: TextStyle(color: Colors.black87),)
                )
              ],
            ),
          ),
    );
  }
}

class PlayerSlider extends StatefulWidget {
  const PlayerSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayerSlider> createState() => _PlayerSliderState();
}

class _PlayerSliderState extends State<PlayerSlider> {

  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<String> imgList = ['', '', ''];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                carouselController: _controller,
                items: [

                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/images/player_01.png', fit: BoxFit.cover, width: 1000.0),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: SvgPicture.asset(
                            'assets/images/heart.svg',
                            color: MainTheme.mainColor,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/images/player_01.png', fit: BoxFit.cover, width: 1000.0),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: SvgPicture.asset(
                            'assets/images/heart.svg',
                            color: Colors.black12,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/images/player_01.png', fit: BoxFit.cover, width: 1000.0),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: SvgPicture.asset(
                            'assets/images/heart.svg',
                            color: Colors.black12,
                            height: 20,
                            allowDrawingOutsideViewBox: true,
                          ),
                        )
                      ],
                    ),
                  ),

                ],
                options: CarouselOptions(
                    aspectRatio: 2.0,
                    viewportFraction: 0.3,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
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
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MainTheme.mainColor.withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      )
    );
  }
}