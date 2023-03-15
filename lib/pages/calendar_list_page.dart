import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/game_model.dart';
import 'package:cd_leonesa_app/services/game_service.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:url_launcher/url_launcher.dart';


class CalendarListPage extends StatefulWidget {

  @override
  State<CalendarListPage> createState() => _CalendarListPageState();
}

class _CalendarListPageState extends State<CalendarListPage> {
  String _month = '01';
  String _year = '';
  List<Map> listOfMonth = [
    { 'num': '01', 'name': 'ENE' },
    { 'num': '02', 'name': 'FEB' },
    { 'num': '03', 'name': 'MAR' },
    { 'num': '04', 'name': 'ABR' },
    { 'num': '05', 'name': 'MAY' },
    { 'num': '06', 'name': 'JUN' },
    { 'num': '07', 'name': 'JUL' },
    { 'num': '08', 'name': 'AGO' },
    { 'num': '09', 'name': 'SEP' },
    { 'num': '10', 'name': 'OCT' },
    { 'num': '11', 'name': 'NOV' },
    { 'num': '12', 'name': 'DIC' },
  ];
  List<Game> listOfGame = [];

  @override
  void initState() {
    super.initState();
    
    _year = DateTime.now().year.toString();
    _month = DateFormat('MM', 'es').format(DateTime.now()).toString();
  }

  List<Widget> _buildMonthList(BuildContext context) {

    final gameService = Provider.of<GameService>(context);

    listOfGame = gameService.getGamesByMonth('$_year-$_month');

    List<Widget> list = [];
    if (_month.isNotEmpty) {
      listOfMonth.forEach((month) {
        list.add(
          GestureDetector(
            onTap: (() {
              setState(() {
                _month = month['num'].toString();
                listOfGame = gameService.getGamesByMonth('$_year-${month['num']}');
              });
            }),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                month['name'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: _month == month['num']
                    ? FontWeight.w800
                    : FontWeight.w400,
                ),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _month == month['num']
                      ? Colors.black87
                      : Colors.transparent,
                    width: 1.5
                  ),
                )
              ),
            ),
          ),
        );
      });
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      background: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Partidos temp.',
                      style: TextStyle(
                          fontSize: 22,
                          color: MainTheme.mainColor,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none
                        ),
                      children: [
                          TextSpan(
                            text: ' ${_year!}',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: '\n${GameService.section}',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: (() {
                    Navigator.pushNamed(context, 'calendar-list');
                  }),
                  minWidth: 0,
                  padding: EdgeInsets.all(0),
                  child: SvgPicture.asset(
                    'assets/images/list.svg',
                    color: MainTheme.mainColor,
                    height: 20,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                MaterialButton(
                  minWidth: 0,
                  onPressed: (() {
                    Navigator.pushNamed(context, 'calendar-grid');
                  }),
                  padding: EdgeInsets.all(0),
                  child: SvgPicture.asset(
                    'assets/images/grid.svg',
                    color: MainTheme.mainColor,
                    height: 20,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Column(
                        children: [
                          ..._buildMonthList(context)
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    listOfGame.isEmpty
                    ? Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'No hay partidos agendados este mes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black26,
                            fontWeight: FontWeight.w200,
                            decoration: TextDecoration.none
                          ),
                        ),
                      ),
                    )
                    : Expanded(
                      child:
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listOfGame.length,
                        itemBuilder: ((context, index) {
                          return EventCard(game: listOfGame[index],);
                        })
                      ) 
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          
        ],
      ),
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
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black12, width: 4)
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
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
                          fontSize: 16,
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
                  Text(
                    DateFormat('HH:mm', 'es').format(game.fecha!).toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none
                      ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
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
                  Text(
                    'JORNADA ${game.jornada}',
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
                        game.local!
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
                      fontSize: 16,
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
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    game.lugarDelParido ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: MainTheme.mainColor,
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.none,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: game.isTicketSale ? MainTheme.mainColor : Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2)
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: game.isTicketSale 
              ? MaterialButton(
                onPressed: () {
                  Uri _url = Uri.parse('https://cydleonesa.acyti.com/');
                  _launchUrl(_url);
                },
                child: Center(
                  child: Text(
                    'COMPRAR ENTRADA',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              : Container(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
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

