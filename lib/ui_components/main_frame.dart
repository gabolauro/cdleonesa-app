import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/game_model.dart';
import 'package:cd_leonesa_app/services/game_service.dart';
import 'package:cd_leonesa_app/services/push_notifications_service.dart';
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

    final currentRoute = ModalRoute.of(context)!.settings.name;

    return Scaffold(
      key: _key,
      drawer: CustomDrawer(),
      backgroundColor: widget.background,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            currentRoute=='home' ? null : Navigator.pushNamed(context, 'home');
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
      height: 60,
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
              // Navigator.pushNamed(context, 'news');
              _submenu(
                context,
                items: [
                  { 'title' : 'Fútbol', 'action' : (){Navigator.pushNamed(context, 'news', arguments: 'Fútbol');} },
                  { 'title' : 'Fútbol Femenino', 'action' : (){Navigator.pushNamed(context, 'news', arguments: 'Fútbol Femenino');} },
                  { 'title' : 'Baloncesto', 'action' : (){Navigator.pushNamed(context, 'news', arguments: 'Baloncesto');} },
                ]
              );
            }
          ),
          // _menuItem(
          //   svgAsset: 'assets/images/team.svg',
          //   title: 'Equipo',
          //   callback: () {
          //     Navigator.pushNamed(context, 'team');
          //   }
          // ),
          _menuItem(
            svgAsset: 'assets/images/calendar.svg',
            title: 'Calendario',
            callback: () {
              // Navigator.pushNamed(context, 'calendar');
              _submenu(
                context,
                items: [
                  { 'title' : 'Fútbol', 'action' : (){
                      GameService.section = 'Futbol';
                      Navigator.pushNamed(context, 'calendar', arguments: 'Fútbol');
                    } },
                  { 'title' : 'Fútbol Femenino', 'action' : (){
                      GameService.section = 'Femenino';
                      Navigator.pushNamed(context, 'calendar', arguments: 'Fútbol Femenino');
                    } },
                  { 'title' : 'Baloncesto', 'action' : (){
                      GameService.section = 'Baloncesto';
                      Navigator.pushNamed(context, 'calendar', arguments: 'Baloncesto');
                    } },
                ]
              );
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
                  height: 18,
                  allowDrawingOutsideViewBox: true,
                ),
                Text(title, style: TextStyle(color: Colors.white, fontSize: 12),)
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

  _submenu(context, {
    required List<Map<String, dynamic>> items
  }) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (BuildContext context) {

        List<Widget> list = [];
        if (items.isNotEmpty) {
          items.forEach((item) {
            list.add( 
              GestureDetector(
                onTap: item['action'],
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white30,
                        width: 1.5
                      ),
                    )
                  ),
                  child: Center(
                    child: Text(
                      item['title'],
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),  
                    ),
                  ),
                ),
              ),
            );
          });
        }

        return Container(
          // height: 200,
          color: Colors.transparent,
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [

              ...list,
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                ),
              ),


            ],
          ),
        );
      },
    );
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
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                color: MainTheme.softGrey,
                height: 75,
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
                    // _itemOption(
                    //   svgAsset: 'assets/images/calendar.svg',
                    //   title: 'Calendario',
                    //   callback: () {
                    //     Navigator.pushNamed(context, 'calendar');
                    //   }
                    // ),
                    // _itemOption(
                    //   svgAsset: 'assets/images/team.svg',
                    //   title: 'Team',
                    //   callback: () {
                    //     PushNotificationService.initialPayload = {
                    //       'forceRedirect' : true,
                    //       'page': 'team',
                    //       'id': '0'
                    //     };
                    //     Navigator.pushNamed(context, 'team');
                    //   }
                    // ),
                    // _itemOption(
                    //   svgAsset: 'assets/images/settings.svg',
                    //   title: 'Ajustes',
                    //   callback: () {
                    //     Navigator.pushNamed(context, 'settings');
                    //   }
                    // ),
                    // _itemOption(
                    //   svgAsset: 'assets/images/send.svg',
                    //   title: 'Enviar alerta a 20 segundos',
                    //   callback: () {

                    //     Map<String, dynamic> payload = {
                    //       'page': 'team',
                    //       'id': '0'
                    //     };

                    //     PushNotificationService.showNotification(
                    //       title: 'Title',
                    //       body: 'Hey you have a new message',
                    //       payload: payload
                    //     );

                    //     PushNotificationService.showScheduledNotification(
                    //       title: 'Notificación de prueba',
                    //       body: 'Alerta agendada',
                    //       payload: payload,
                    //       scheduledDate: DateTime.now().add(Duration(seconds: 20))
                    //     );
                    //     Navigator.pop(context);
                    //   }
                    // ),
                  ],
                ),
              ),
            ],
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