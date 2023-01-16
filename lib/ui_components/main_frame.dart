import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:url_launcher/url_launcher.dart';


class MainFrame extends StatefulWidget {

  final Widget body;
  final Color? background;
  static int currentIndex = 0;

  const MainFrame({
    Key? key,
    required this.body,
    this.background = MainTheme.mainColor,
  }) : super(key: key);

  @override
  State<MainFrame> createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {

  late int currentIndex;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {

    currentIndex = MainFrame.currentIndex;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: CustomDrawer(),
      backgroundColor: widget.background,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'home');
          },
          child: Container(
            padding: EdgeInsets.only(left: 20),
            child: Image.asset(
              'assets/images/logo_01.png',
            ),
          ),
        ),
        leadingWidth: 52,
        actions: [
          IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: SvgPicture.asset(
                'assets/images/menu.svg',
                color: MainTheme.mainColor,
                height: 28,
                allowDrawingOutsideViewBox: true,
              )
          )
        ],
      ),
      body: this.widget.body,
     bottomNavigationBar: Container(
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MainTheme.mainColorDark,
            MainTheme.mainColor
          ]
        )
      ),
       child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _menuItem(
            svgAsset: 'assets/images/news.svg',
            title: 'Noticias',
            callback: () {
              Navigator.pushNamed(context, 'news');
            }
          ),
          _menuItem(
            svgAsset: 'assets/images/team.svg',
            title: 'Equipo',
            callback: () {
              Navigator.pushNamed(context, 'team');
            }
          ),
          _menuItem(
            svgAsset: 'assets/images/store.svg',
            title: 'Tienda',
            callback: () {
              Uri _url = Uri.parse('https://shop.cydleonesa.com/es/');
              _launchUrl(_url);
            }
          ),
          _menuItem(
            svgAsset: 'assets/images/museum.svg',
            title: 'Museo',
            callback: () {
              Uri _url = Uri.parse('https://estadio-virtual.cydleonesa.com/');
              _launchUrl(_url);
            }
          ),
        ],
       )
     ),
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
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  svgAsset,
                  color: Colors.white,
                  height: 22,
                  allowDrawingOutsideViewBox: true,
                ),
                Text(title, style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MainTheme.mainColor,
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height/4,
            left: -MediaQuery.of(context).size.width/4,
            child: Container(
              height: MediaQuery.of(context).size.width *1.5,
              width: MediaQuery.of(context).size.width *1.5,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    MainTheme.mainColorDark.withOpacity(0.8),
                    Colors.transparent
                  ]
                )
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 55,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    margin: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/logo_01.png',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _itemOption(
                        svgAsset: 'assets/images/send.svg',
                        title: 'Patrocinadores',
                        callback: () {
                          Navigator.pushNamed(context, 'partners');
                        }
                      ),
                      _itemOption(
                        svgAsset: 'assets/images/century.svg',
                        title: 'Centenario',
                        callback: () {
                          Navigator.pushNamed(context, 'century');
                        }
                      ),
                      _itemOption(
                        svgAsset: 'assets/images/calendar.svg',
                        title: 'Calendario',
                        callback: () {
                          Navigator.pushNamed(context, 'calendar');
                        }
                      ),
                      _itemOption(
                        svgAsset: 'assets/images/settings.svg',
                        title: 'Ajustes',
                        callback: () {
                          Navigator.pushNamed(context, 'settings');
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _itemOption({
    required String svgAsset,
    required String title,
    required Function() callback
  }) {
    return Row(
        children: [
          Container(
            width: 30,
            child: SvgPicture.asset(
              svgAsset,
              color: Colors.white,
              height: 22,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8),
              child: TextButton(
                onPressed: callback,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
            ),
          )
        ],
      );
  }
}