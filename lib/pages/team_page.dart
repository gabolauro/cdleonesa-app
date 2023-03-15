import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/game_model.dart';
import 'package:cd_leonesa_app/models/player_model.dart';
import 'package:cd_leonesa_app/services/game_service.dart';
import 'package:cd_leonesa_app/services/player_service.dart';
import 'package:cd_leonesa_app/services/preferences.dart';
import 'package:cd_leonesa_app/services/push_notifications_service.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class TeamPage extends StatefulWidget {

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  static late Game lastGame;
  bool isSending = false;


  @override
  void initState() {
    super.initState();

    GameService.section = 'Futbol';

    final gameService = Provider.of<GameService>(context, listen: false);
    lastGame = gameService.getGameForSurvey();

    if (Preferences.gameId != lastGame.id) {
      Preferences.resetAllValues();
      Preferences.gameId = lastGame.id!;
    }
  }

  _validateSurvey() async {
    setState(() { isSending = true; });
    String userId = PushNotificationService.token;
    Map<String, dynamic> payload = {
        "title": "${lastGame.id}-user${userId}",
        "post_type": "encuesta",
        "content": "",
        "status": "publish",
        "acf": {
            "jornada": lastGame.jornada.toString(),
            "id_del_usuario": userId,
            "temporada": lastGame.temporada,
            "competicion": lastGame.competicion,
            "Visto": Preferences.place,
            "mvp": Preferences.player.toString(),
            "ataque": Preferences.attack.toString(),
            "defensa": Preferences.fence.toString()
        }
    };
    if (await GameService.sendSurvey(payload)) {
      PushNotificationService.initialPayload = {'forceRedirect':false};
      Navigator.pushNamed(context, 'home');
    }
    setState(() { isSending = false; });
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      background: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                children: [
                  Text(
                    'JORNADA ${lastGame.jornada}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.none,
                      letterSpacing: 3
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity, maxHeight: 80),
                    child: Row(
                      children: [
                        lastGame.local!
                          ? _theTeam()
                          : _otherTeam(),
                        Text(
                          'VS',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                            color: Colors.black12,
                            letterSpacing: -5
                          ),
                        ),
                        lastGame.local!
                          ? _otherTeam()
                          : _theTeam(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '¿Dónde has visto el partido?',
                style: TextStyle(
                  fontSize: 20,
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
                  active: Preferences.place == 'No lo he visto: No',
                  callback: () {
                    Preferences.place = 'No lo he visto: No';
                    setState(() {});
                  }
                ),
                _menuItem(
                  svgAsset: 'assets/images/stadium.svg',
                  title: 'En el campo',
                  active: Preferences.place == 'En el campo: campo',
                  callback: () {
                    Preferences.place = 'En el campo: campo';
                    setState(() {});
                  }
                ),
                _menuItem(
                  svgAsset: 'assets/images/tv.svg',
                  title: 'Por la TV',
                  active: Preferences.place == 'Por TV: TV',
                  callback: () {
                    Preferences.place = 'Por TV: TV';
                    setState(() {});
                  }
                ),
              ],
            ),
            Text(
              '¿Quién ha sido el MVP?',
              style: TextStyle(
                fontSize: 20,
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
                  fontSize: 20,
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
                              height: MediaQuery.of(context).size.height *0.02,
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
                        SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                        Container(
                          height: MediaQuery.of(context).size.height *0.03,
                          width: double.infinity,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder:(context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Preferences.attack = index+1;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 7),
                                  child: SvgPicture.asset(
                                    'assets/images/star.svg',
                                    color: index+1 <= Preferences.attack
                                      ? MainTheme.mainColor
                                      : Colors.black12,
                                    height: MediaQuery.of(context).size.height *0.03,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 1,
                    height: MediaQuery.of(context).size.height *0.1,
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
                              height: MediaQuery.of(context).size.height *0.02,
                              allowDrawingOutsideViewBox: true,
                            )
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                        Container(
                          height: MediaQuery.of(context).size.height *0.03,
                          width: double.infinity,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder:(context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Preferences.fence = index+1;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 7),
                                  child: SvgPicture.asset(
                                    'assets/images/star.svg',
                                    color: index+1 <= Preferences.fence
                                      ? MainTheme.mainColor
                                      : Colors.black12,
                                    height: MediaQuery.of(context).size.height *0.03,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *0.2),
              margin: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  isSending ? null : _validateSurvey();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => 
                    isSending
                    ? Colors.transparent
                    : MainTheme.mainColor),
                  elevation: MaterialStateProperty.resolveWith((states) => 0)
                ),
                child:
                isSending
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator()
                  )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Enviar',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.none
                            ),
                          children: [
                              TextSpan(
                                text: ' valoración',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/images/send.svg',
                        color: Colors.white,
                        height: 14,
                        allowDrawingOutsideViewBox: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
   );
  }

  Expanded _otherTeam() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5),
        child:
        lastGame.resourceMedia != null
          ? Image.network(
            lastGame.resourceMedia ?? '',
            fit: BoxFit.contain,)
          : Icon(Icons.shield, size: 50, color: Colors.black26,),
      ),
    );
  }

  Expanded _theTeam() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Image.asset('assets/images/logo_01.png'),
      ),
    );
  }

  Widget _menuItem({
    required String svgAsset,
    required String title,
    required bool active,
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
                  color: active 
                    ? MainTheme.mainColor
                    : Colors.black26,
                  height: MediaQuery.of(context).size.height *0.03,
                  allowDrawingOutsideViewBox: true,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: active 
                        ? Colors.black87
                        : Colors.black26,
                    ),
                  )
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
  @override
  Widget build(BuildContext context) {

    final playerService = Provider.of<PlayerService>(context);

    List<PlayerCard> _buildNextGames() {
      List<PlayerCard> list = [];
      playerService.allPlayers.forEach((player) {
        list.add(
          PlayerCard(player: player,)
        );
      });
      return list;
    }

    return Container(
      height: 250,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: _controller,
              items: [

                ..._buildNextGames()

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
            children: _buildNextGames().asMap().entries.map((entry) {
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
    );
  }
}

class PlayerCard extends StatelessWidget {
  final Player player;
  const PlayerCard({
    Key? key,
    required this.player
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final playerService = Provider.of<PlayerService>(context);

    return GestureDetector(
      onDoubleTap: (() {
        playerService.setFavPlayer(player.id ?? 0);
      }),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.network(
                      player.resourceMedia ?? '',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        player.numberId.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'SairaCondensed',
                          fontWeight: FontWeight.w800,
                          color: Colors.black26,
                          fontSize: 32,
                          letterSpacing: 0,
                          height: 1
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            RichText(
                              maxLines: 2,
                              text: TextSpan(
                                text: player.name!.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'SairaCondensed',
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.none,
                                    color: Colors.black87,
                                    letterSpacing: 0,
                                    height: 1
                                  ),
                                children: [
                                    TextSpan(
                                      text: '\n${player.demarcacion}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                onTap: (() {
                  playerService.setFavPlayer(player.id ?? 0);
                  // _TeamPageState._validateSurvey();
                }),
                child: SvgPicture.asset(
                  'assets/images/heart.svg',
                  color: player.id == Preferences.player
                    ? MainTheme.mainColor
                    : Colors.black12,
                  height: 20,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}