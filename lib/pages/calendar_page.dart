import 'package:carousel_slider/carousel_slider.dart';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/game_model.dart';
import 'package:cd_leonesa_app/services/game_service.dart';
import 'package:cd_leonesa_app/ui_components/last_game.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final gameService = Provider.of<GameService>(context);
    final section = ModalRoute.of(context)!.settings.arguments as String;
    // List newsList() {
    //   if (section=='Fútbol') {
    //     return newsServide.futbolNewsList;
    //   } else if (section=='Fútbol Femenino') {
    //     return newsServide.femaleFutbolNewsList;
    //   } else if (section=='Baloncesto') {
    //     return newsServide.basketNewsList;
    //   }
    //   return [];
    // };

    List<EventCard> _buildNextGames() {
      List<EventCard> list = [];
      gameService.getNextGames().forEach((game) {
        list.add(
          EventCard(game: game,)
        );
      });
      return list;
    }

    return MainFrame(
      background: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Calendario',
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

            _buildNextGames().isEmpty
            ? Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                'No hay próximos partidos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black26,
                  fontWeight: FontWeight.w200,
                  decoration: TextDecoration.none
                ),
              ),
            )
            : CarouselSlider(
              items: [
      
                ..._buildNextGames(),
      
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
      
            Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *0.2),
              margin: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'calendar-list');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: RichText(
                        text: const TextSpan(
                          text: 'Ver',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.none
                            ),
                          children: [
                              TextSpan(
                                text: ' calendario completo',
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
                        'assets/images/arrow_right.svg',
                        color: Colors.white,
                        height: 14,
                        allowDrawingOutsideViewBox: true,
                      ),
                    )
                  ],
                ),
              ),
            ),

            gameService.getLastGames().isEmpty
            ? Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                'No hay previos partidos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black26,
                  fontWeight: FontWeight.w200,
                  decoration: TextDecoration.none
                ),
              ),
            )
            : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              itemCount: gameService.getLastGames().length,
              itemBuilder:(context, i) {
                return LastGame(
                  background: i%2 != 0
                    ? Colors.black.withOpacity(0.05)
                    : Colors.white,
                  game: gameService.getLastGames()[i],
                );
              },
            )
          ],
        ),
      )
   );
  }
}

class EventCard extends StatelessWidget {
  final Game game;
  const EventCard({
    Key? key,
    required this.game,
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
                            text: DateFormat('EEEE', 'es').format(game.fecha!).toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w200,
                                decoration: TextDecoration.none
                              ),
                            children: [
                                TextSpan(
                                  text: DateFormat(' dd MMMM', 'es').format(game.fecha!).toUpperCase(),
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
                                game.local!
                                  ? _theTeam()
                                  : _otherTeam(),
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
                                game.local!
                                  ? _otherTeam()
                                  : _theTeam(),
                              ],
                            ),
                          ),
                          Text(
                            game.local!
                              ? 'Cultural'
                              : game.equipoContrario!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            !game.local!
                              ? 'Cultural'
                              : game.equipoContrario!,
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
                      game.lugarDelParido ?? '',
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

  Expanded _otherTeam() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5),
        child:
        game.resourceMedia != null
          ? Image.network(
            game.resourceMedia ?? '',
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
}